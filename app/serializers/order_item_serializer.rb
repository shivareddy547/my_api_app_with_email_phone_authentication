class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :menu_item_id, :quantity, :unit_price, :created_at, :updated_at
  
  belongs_to :order
end
