require 'swagger_helper'

RSpec.describe 'Tables API', type: :request do

  path '/api/tables' do
    get 'List tables' do
      tags 'Tables'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/tables/:id' do
    get 'Show tables' do
      tags 'Tables'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/tables' do
    post 'Create tables' do
      tags 'Tables'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/tables/:id' do
    put 'Update tables' do
      tags 'Tables'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/tables/:id' do
    patch 'Update tables' do
      tags 'Tables'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/tables/:id' do
    delete 'Delete tables' do
      tags 'Tables'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
