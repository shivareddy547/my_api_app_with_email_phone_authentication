require 'swagger_helper'

RSpec.describe 'Floorscontroller API', type: :request do

  path '/api/floors' do
    get 'List floors' do
      tags 'Floors'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/floors/{id}' do
    get 'Show floors' do
      tags 'Floors'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/floors' do
    post 'Create floors' do
      tags 'Floors'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/floors/{id}' do
    put 'Update floors' do
      tags 'Floors'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/floors/{id}' do
    patch 'Update floors' do
      tags 'Floors'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/floors/{id}' do
    delete 'Delete floors' do
      tags 'Floors'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
