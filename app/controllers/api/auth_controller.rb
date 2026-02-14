# app/controllers/api/auth_controller.rb
module Api
  class AuthController < ApplicationController
    skip_before_action :authenticate_request,
      only: [:login, :signup, :otp_login, :verify_otp, :refresh, :forgot_password, :reset_password]

    # ============================
    # SIGNUP
    # ============================
    def signup
      user = User.new(signup_params)

      if user.save
        token = user.generate_jwt

        render_success(
          {
            user: user_serializer(user),
            token: token,
            token_type: 'Bearer',
            expires_in: 24.hours.to_i
          },
          'Account created successfully',
          :created
        )
      else
        render_error('Account creation failed', user.errors.full_messages)
      end
    end

    # ============================
    # EMAIL / PASSWORD LOGIN
    # ============================
    def login
      user = User.find_for_database_authentication(login: login_params[:login])

      return render_error('Invalid login credentials') unless user
      return render_error('Account is locked') if user.access_locked?


      if user.valid_password?(login_params[:password])
        user.update(failed_attempts: 0)

        render_success(
          {
            user: user_serializer(user),
            token: user.generate_jwt,
            token_type: 'Bearer',
            expires_in: 24.hours.to_i,
            refresh_token: generate_refresh_token(user)
          },
          'Login successful'
        )
      else
        user.increment_failed_attempts
        render_error('Invalid login credentials')
      end
    end

    # ============================
    # OTP LOGIN (WHATSAPP → EMAIL)
    # ============================
    def otp_login
      phone_number = params[:phone_number]
      return render_error('Phone number is required') if phone_number.blank?

      phone = Phonelib.parse(phone_number)
      return render_error('Invalid phone number format') unless phone.valid?

      formatted_phone = phone.e164

      user = User.find_or_initialize_by(phone_number: formatted_phone)
      if user.new_record?
        user.password = Devise.friendly_token[0, 20]
        user.save!
      end

      return render_error('Too many OTP attempts. Try again later.') if user.otp_locked?

      otp = user.send_otp_via_sms   # ✅ WhatsApp primary → Email fallback

      response_data = {
        phone_number: mask_phone_number(formatted_phone),
        expires_in: 300
      }

      # DEV ONLY
      unless Rails.env.production?
        response_data[:otp] = otp
      end

      render_success(response_data, 'OTP sent successfully')
    end

    # ============================
    # VERIFY OTP
    # ============================
    def verify_otp
      phone_number = params[:phone_number]
      otp_attempt  = params[:otp]

      return render_error('Phone number and OTP are required') if phone_number.blank? || otp_attempt.blank?

      phone = Phonelib.parse(phone_number)
      user  = User.find_by(phone_number: phone.e164)

      return render_error('User not found') unless user
      return render_error('OTP locked. Try later.') if user.otp_locked?

      if user.verify_otp(otp_attempt)
        render_success(
          {
            user: user_serializer(user),
            token: user.generate_jwt,
            token_type: 'Bearer',
            expires_in: 24.hours.to_i,
            phone_verified: true
          },
          'OTP verified successfully'
        )
      else
        render_error('Invalid or expired OTP')
      end
    end

    # ============================
    # TOKEN REFRESH
    # ============================
    def refresh
      refresh_token = params[:refresh_token] || request.headers['Refresh-Token']
      return render_error('Refresh token is required') unless refresh_token.present?

      decoded = decode_token(refresh_token)
      user = User.find(decoded['user_id'])

      render_success(
        {
          token: user.generate_jwt,
          token_type: 'Bearer',
          expires_in: 24.hours.to_i
        },
        'Token refreshed successfully'
      )
    rescue
      render_error('Invalid refresh token')
    end

    # ============================
    # LOGOUT
    # ============================
    def logout
      if current_user && decoded_token
        current_user.jwt_denylists.create!(
          jti: decoded_token['jti'],
          exp: Time.at(decoded_token['exp'])
        )
        render_success(nil, 'Logged out successfully')
      else
        render_error('No active session found')
      end
    end

    # ============================
    # CURRENT USER
    # ============================
    def me
      render_success(
        { user: user_serializer(current_user) },
        'User details retrieved'
      )
    end

    # ============================
    # FORGOT PASSWORD
    # ============================
    def forgot_password
      email_or_phone = params[:email_or_phone]
      return render_error('Email or phone is required') if email_or_phone.blank?

      user =
        if email_or_phone.include?('@')
          User.find_by(email: email_or_phone)
        else
          User.find_by(phone_number: Phonelib.parse(email_or_phone).e164)
        end

      return render_error('User not found') unless user

      token = SecureRandom.urlsafe_base64
      user.update!(
        reset_password_token: Devise.token_generator.digest(User, :reset_password_token, token),
        reset_password_sent_at: Time.current
      )

      render_success({ reset_token: token }, 'Password reset instructions sent')
    end

    # ============================
    # RESET PASSWORD
    # ============================
    def reset_password
      token = params[:token]
      password = params[:password]
      confirmation = params[:password_confirmation]

      return render_error('Invalid parameters') if token.blank? || password.blank?
      return render_error('Password confirmation mismatch') if password != confirmation

      user = User.find_by(
        reset_password_token: Devise.token_generator.digest(User, :reset_password_token, token)
      )

      return render_error('Invalid or expired token') unless user&.reset_password_sent_at&.> 1.hour.ago

      user.update!(
        password: password,
        reset_password_token: nil,
        reset_password_sent_at: nil,
        failed_attempts: 0
      )

      render_success(nil, 'Password reset successful')
    end

    # ============================
    # PRIVATE
    # ============================
    private

    def signup_params
      params.require(:auth).permit(:email, :password, :password_confirmation, :phone_number, :name)
    end

    def login_params
      params.require(:auth).permit(:login, :password)
    end

    def user_serializer(user)
      {
        id: user.id,
        email: user.email,
        phone_number: mask_phone_number(user.phone_number),
        name: user.name,
        admin: user.admin,
        phone_verified: user.phone_verified,
        email_verified: user.email_verified,
        created_at: user.created_at,
        updated_at: user.updated_at
      }
    end

    def mask_phone_number(phone)
      "#{'*' * (phone.length - 4)}#{phone[-4..]}"
    end

    def generate_refresh_token(user)
      payload = {
        user_id: user.id,
        type: 'refresh',
        jti: SecureRandom.uuid,
        exp: 7.days.from_now.to_i
      }

      JWT.encode(payload, ENV.fetch('DEVISE_JWT_SECRET_KEY'), 'HS256')
    end
  end
end
