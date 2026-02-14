class ApplicationController < ActionController::API
  before_action :set_default_format
  before_action :authenticate_request

  attr_reader :current_user
  attr_reader :decoded_token

  # Rescue from common exceptions
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from JWT::DecodeError, with: :invalid_token
  rescue_from JWT::ExpiredSignature, with: :token_expired

  protected

  def authenticate_request
    header = request.headers['Authorization']

    unless header&.start_with?('Bearer ')
      return if public_endpoint?
      return render_unauthorized('Missing authentication token')
    end

    token = header.split(' ').last
    authenticate_with_token(token)
  end

  def authenticate_with_token(token)
    @decoded_token = decode_token(token)
    @current_user = User.find(@decoded_token['user_id'])

    # Check if token is revoked
    if JwtDenylist.exists?(jti: @decoded_token['jti'])
      render_unauthorized('Token has been revoked')
    end
  rescue ActiveRecord::RecordNotFound
    render_unauthorized('User not found')
  end

  def public_endpoint?
    controller_name == 'auth' &&
    action_name.in?(%w[login otp_login verify_otp signup refresh])
  end

  def decode_token(token)
    JWT.decode(
      token,
      ENV.fetch('DEVISE_JWT_SECRET_KEY'),
      true,
      { algorithm: 'HS256' }
    ).first
  end

  def set_default_format
    request.format = :json
  end

  # Response helpers
  def render_success(data = nil, message = 'Success', status = :ok)
    response = { success: true, message: message }
    response[:data] = data if data
    render json: response, status: status
  end

  def render_error(message, errors = nil, status = :unprocessable_entity)
    response = { success: false, message: message }
    response[:errors] = errors if errors
    render json: response, status: status
  end

  # Exception handlers
  def record_not_found(exception)
    render_error('Resource not found', nil, :not_found)
  end

  def invalid_token(exception)
    render_error('Invalid authentication token', nil, :unauthorized)
  end

  def token_expired(exception)
    render_error('Authentication token has expired', nil, :unauthorized)
  end

  def render_unauthorized(message = 'Not authorized')
    render_error(message, nil, :unauthorized)
  end

  def render_forbidden(message = 'Access denied')
    render_error(message, nil, :forbidden)
  end

  # Rate limiting helper
  def check_rate_limit(key, limit: 5, period: 1.hour)
    count = Rails.cache.read(key) || 0

    if count >= limit
      render_error("Too many requests. Please try again later.", nil, :too_many_requests)
      false
    else
      Rails.cache.write(key, count + 1, expires_in: period)
      true
    end
  end
end