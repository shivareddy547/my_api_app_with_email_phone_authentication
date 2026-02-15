# Backend file for user 1, project my_api_app
# Path: app/serializers/contact_serializer.rb
class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :description, :created_at, :updated_at
end
