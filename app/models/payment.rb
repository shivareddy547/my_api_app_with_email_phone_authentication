class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :order

  # Attributes:
  #   :order_id (integer)
  #   :amount (decimal)
  #   :currency (string)
  #   :payment_method (string)
  #   :payment_provider (string)
  #   :status (string)
  #   :transaction_id (string)
  #   :processed_at (datetime)
  #   :user_id (integer)

end