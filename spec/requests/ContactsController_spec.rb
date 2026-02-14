require 'swagger_helper'

RSpec.describe 'Contactscontroller API', type: :request do

  path '/api/contacts' do
    post 'Create contacts' do
      tags 'Contacts'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        run_test!
      end
    end
  end
end
