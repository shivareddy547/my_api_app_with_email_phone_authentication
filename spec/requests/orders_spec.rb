require 'swagger_helper'

RSpec.describe 'Orders API', type: :request do

  path '/api/orders' do
    get 'List orders' do
      tags 'Orders'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/orders/:id' do
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

  path '/api/orders/:id' do
    put 'Update orders' do
      tags 'Orders'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/orders/:id' do
    patch 'Update orders' do
      tags 'Orders'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
