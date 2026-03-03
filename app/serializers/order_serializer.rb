class OrderSerializer < ActiveModel::Serializer
  attributes :id, :items, :subtotal, :tax, :total, :status, :payment_method, :user_id, :created_at, :updated_at, :order_type, :table_id, :customer_name, :floor_id
  belongs_to :table
  belongs_to :floor
  has_many :order_items
end
