require 'swagger_helper'

RSpec.describe 'Authcontroller API', type: :request do

  path '/api/auth/signup' do
    post 'POST /api/auth/signup' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/auth/login' do
    post 'POST /api/auth/login' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/auth/otp_login' do
    post 'POST /api/auth/otp_login' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/auth/verify_otp' do
    post 'POST /api/auth/verify_otp' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/auth/refresh' do
    post 'POST /api/auth/refresh' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/auth/logout' do
    delete 'DELETE /api/auth/logout' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/auth/me' do
    get 'GET /api/auth/me' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/auth/password/forgot' do
    post 'POST /api/auth/password/forgot' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/auth/password/reset' do
    post 'POST /api/auth/password/reset' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
