class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item, class_name: 'MenuItem'

  # Attributes:
  #   :order_id (integer)
  #   :menu_item_id (integer)
  #   :quantity (integer)
  #   :unit_price (decimal)
  #   :total_price (decimal)

end