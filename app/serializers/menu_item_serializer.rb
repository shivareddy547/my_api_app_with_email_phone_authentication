class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :category, :description, :available, :image, :created_at, :updated_at
end
