# Minimal RSwag configuration
if defined?(Rswag::Api)
  Rswag::Api.configure do |config|
    config.openapi_root = Rails.root.join('swagger').to_s
    config.swagger_root = Rails.root.join('swagger').to_s
  end
end

if defined?(Rswag::Ui)
  Rswag::Ui.configure do |config|
    # Add cache-busting timestamp
    timestamp = Time.now.to_i
    config.swagger_endpoint "/api-docs/v1/swagger.yaml?v=#{timestamp}", 'API V1 Docs'
  end
end
