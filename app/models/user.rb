# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :lockable, :timeoutable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :phone_number, presence: true, uniqueness: true
  validates :phone_number, phone: { possible: true, allow_blank: true }

  validate :email_or_phone_present

  before_validation :format_phone_number
  before_create :generate_otp_secret

  has_many :jwt_denylists, dependent: :destroy

  has_many :menu_items, class_name: 'MenuItem'
  has_many :categories, class_name: 'Category'
  has_many :orders, class_name: 'Order'
  has_many :payments, class_name: 'Payment'
   has_many :floors, class_name: 'Floor'
  has_many :tables, class_name: 'Table'
  has_many :staff_members, class_name: 'StaffMember'

  # ===============================
  # OTP CORE
  # ===============================

  def generate_otp
    totp = ROTP::TOTP.new(otp_secret_key, issuer: Rails.application.class.module_parent_name)
    totp.now
  end

  def verify_otp(otp_attempt)
    return false if otp_locked?
    return false unless otp_secret_key.present? && otp_sent_at.present?
    return false if otp_sent_at < 5.minutes.ago

    totp = ROTP::TOTP.new(otp_secret_key)

    verified = totp.verify(
      otp_attempt,
      at: otp_sent_at,
      drift_behind: 30,
      drift_ahead: 30
    )

    if verified
      update!(
        failed_otp_attempts: 0,
        otp_locked_until: nil,
        phone_verified: true
      )
      true
    else
      increment_failed_otp_attempts
      false
    end
  end

  def otp_locked?
    otp_locked_until.present? && otp_locked_until > Time.current
  end

  def increment_failed_otp_attempts
    attempts = (failed_otp_attempts || 0) + 1

    update(
      failed_otp_attempts: attempts,
      otp_locked_until: attempts >= 5 ? 1.hour.from_now : nil
    )
  end

  def send_otp_via_sms
    otp = generate_otp
    update!(otp_sent_at: Time.current)

    begin
      send_twilio_whatsapp(otp)
      Rails.logger.info "OTP sent via WhatsApp"
    rescue => e
      Rails.logger.error "WhatsApp failed: #{e.message}"
      send_email_otp(otp) if email.present?
    end

    otp
  end

  def send_twilio_whatsapp(otp)
    client = Twilio::REST::Client.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTH_TOKEN']
    )

    client.messages.create(
      from: "whatsapp:#{ENV['TWILIO_WHATSAPP_NUMBER']}",
      to: "whatsapp:#{phone_number}",
      content_sid: ENV['TWILIO_OTP_CONTENT_SID'],
      content_variables: {
        "1" => otp.to_s
      }.to_json
    )
  end

  def send_email_otp(otp)
    return unless email.present?
    UserMailer.otp_email(self, otp).deliver_later
  end

  def generate_jwt
    JWT.encode(jwt_payload, ENV.fetch('DEVISE_JWT_SECRET_KEY'), 'HS256')
  end

  def jwt_payload
    {
      user_id: id,
      email: email,
      phone_number: phone_number,
      admin: admin,
      jti: SecureRandom.uuid,
      iat: Time.current.to_i,
      exp: 24.hours.from_now.to_i
    }
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)

    if login
      where(conditions).where(
        "lower(email) = :value OR phone_number = :value",
        value: login.downcase
      ).first
    else
      where(conditions).first
    end
  end

  private

  def email_or_phone_present
    return if email.present? || phone_number.present?
    errors.add(:base, 'Either email or phone number must be present')
  end

  def format_phone_number
    return if phone_number.blank?
    phone = Phonelib.parse(phone_number)
    self.phone_number = phone.e164 if phone.valid?
  end

  def generate_otp_secret
    self.otp_secret_key ||= ROTP::Base32.random
  end
end