require 'swagger_helper'

RSpec.describe 'Categoriescontroller API', type: :request do

  path '/api/categories' do
    get 'List categories' do
      tags 'Categories'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/categories' do
    post 'Create categories' do
      tags 'Categories'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/categories/{id}' do
    delete 'Delete categories' do
      tags 'Categories'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
