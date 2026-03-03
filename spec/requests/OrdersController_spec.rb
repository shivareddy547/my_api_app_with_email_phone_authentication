require 'swagger_helper'

RSpec.describe 'Orderscontroller API', type: :request do

  path '/api/orders/{id}' do
    get 'Show orders' do
      tags 'Orders'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/orders' do
    post 'Create orders' do
      tags 'Orders'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
