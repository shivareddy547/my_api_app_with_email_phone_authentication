# spec/support/authentication_helper.rb
module AuthenticationHelper
  def auth_headers(user)
    token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
    { 'Authorization' => "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :request
end