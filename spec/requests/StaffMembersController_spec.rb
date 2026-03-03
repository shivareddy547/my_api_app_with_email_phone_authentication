require 'swagger_helper'

RSpec.describe 'Staffmemberscontroller API', type: :request do

  path '/api/staff' do
    get 'List staff' do
      tags 'Staff Members'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/staff/{id}' do
    get 'Show staff' do
      tags 'Staff Members'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/staff' do
    post 'Create staff' do
      tags 'Staff Members'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/staff/{id}' do
    put 'Update staff' do
      tags 'Staff Members'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/staff/{id}' do
    patch 'Update staff' do
      tags 'Staff Members'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/staff/{id}' do
    delete 'Delete staff' do
      tags 'Staff Members'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/staff/{id}/status' do
    patch 'PATCH /api/staff/{id}/status' do
      tags 'Staff Members'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
