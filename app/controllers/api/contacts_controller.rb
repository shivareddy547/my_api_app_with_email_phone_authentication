# Backend file for user 1, project my_api_app
# Path: app/controllers/api/contacts_controller.rb
module Api
  class ContactsController < ApplicationController
    def index
      @contacts = Contact.all
      render json: @contacts, status: :ok
    end

    def create
      @contact = Contact.new(contact_params)
      
      if @contact.save
        render json: { message: 'Contact created successfully' }, status: :created
      else
        render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def contact_params
      params.require(:contact).permit(:name, :email, :description)
    end
  end
end
