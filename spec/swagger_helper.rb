require 'rails_helper'

RSpec.configure do |config|
  # Define the Swagger documents that should be served
  config.swagger_root = Rails.root.join('swagger').to_s

  # Configure Swagger JSON files
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1',
        description: 'This is the API documentation for the application.',

        contact: {
          name: 'API Support',
          email: 'support@example.com'
        },
        license: {
          name: 'MIT',
          url: 'https://opensource.org/licenses/MIT'
        }
      },
      servers: [
        {
          url: "http://localhost:3001",
          description: 'Development server'
        }
      ],
      paths: {},
      components: {
        schemas: {
          Error: {
            type: :object,
            properties: {
              error: { type: :string },
              message: { type: :string }
            }
          }
        },
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'JWT'
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file
  config.swagger_format = :yaml

  # Auto-generate examples from responses
  config.after(:each, type: :request) do |example|
    if response&.body&.present?
      example.metadata[:response][:content] = {
        'application/json' => {
          example: JSON.parse(response.body, symbolize_names: true)
        }
      }
    end
  end
end
