require 'swagger_helper'

RSpec.describe 'Paymentscontroller API', type: :request do

  path '/api/payments/process' do
    post 'POST /api/payments/process' do
      tags 'Payments'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
