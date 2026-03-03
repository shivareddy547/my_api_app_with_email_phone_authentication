class MenuItem < ApplicationRecord
  belongs_to :user

has_many :order_items, class_name: 'OrderItem', dependent: :destroy
  has_many :orders, through: :order_items
  # Attributes:
  #   :name (string)
  #   :price (decimal)
  #   :category (string)
  #   :description (text)
  #   :available (boolean)
  #   :image (text)
  #   :user_id (integer)

end