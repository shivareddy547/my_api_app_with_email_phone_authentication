Devise.setup do |config|
  # ==> Mailer Configuration
  config.mailer_sender = 'no-reply@example.com'
  
  # ==> ORM configuration
  require 'devise/orm/active_record'
  
  # ==> API Configuration
  config.skip_session_storage = [:http_auth, :params_auth]
  config.navigational_formats = []
  
  # ==> JWT Configuration
  config.jwt do |jwt|
    jwt.secret = ENV.fetch('DEVISE_JWT_SECRET_KEY') do
      Rails.application.credentials.devise_jwt_secret_key || 'fallback_secret_change_in_production'
    end
    
    jwt.dispatch_requests = [
      ['POST', %r{^/api/auth/login$}],
      ['POST', %r{^/api/auth/signup$}],
      ['POST', %r{^/api/auth/otp_login$}],
      ['POST', %r{^/api/auth/verify_otp$}],
      ['POST', %r{^/api/auth/refresh$}]
    ]
    
    jwt.revocation_requests = [
      ['DELETE', %r{^/api/auth/logout$}]
    ]
    
    jwt.expiration_time = 24.hours.to_i
  end
  
  # ==> Security Configuration
  config.stretches = Rails.env.test? ? 1 : 12
  config.pepper = ENV['DEVISE_PEPPER'] if ENV['DEVISE_PEPPER']
  
  # ==> OTP Configuration (REMOVED - not a Devise config)
  # config.otp_length = 6
  # config.otp_allowed_drift = 300 # 5 minutes
  
  # ==> Lock Configuration
  config.maximum_attempts = 5
  config.lock_strategy = :failed_attempts
  config.unlock_strategy = :time
  config.unlock_in = 1.hour
end