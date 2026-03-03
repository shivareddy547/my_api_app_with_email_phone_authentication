require 'swagger_helper'

RSpec.describe 'Reportscontroller API', type: :request do

  path '/api/reports/stats' do
    get 'GET /api/reports/stats' do
      tags 'Reports'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/reports/top-items' do
    get 'GET /api/reports/top-items' do
      tags 'Reports'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/reports/recent-orders' do
    get 'GET /api/reports/recent-orders' do
      tags 'Reports'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/reports/hourly-sales' do
    get 'GET /api/reports/hourly-sales' do
      tags 'Reports'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
