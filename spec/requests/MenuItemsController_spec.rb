require 'swagger_helper'

RSpec.describe 'Menuitemscontroller API', type: :request do

  path '/api/menu_items' do
    get 'List menu_items' do
      tags 'Menu Items'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/menu_items' do
    post 'Create menu_items' do
      tags 'Menu Items'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/menu_items/{id}' do
    put 'Update menu_items' do
      tags 'Menu Items'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/menu_items/{id}' do
    patch 'Update menu_items' do
      tags 'Menu Items'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end

  path '/api/menu_items/{id}' do
    delete 'Delete menu_items' do
      tags 'Menu Items'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
