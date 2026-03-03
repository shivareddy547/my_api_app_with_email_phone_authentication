class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :amount, :currency, :payment_method,
             :payment_provider, :status, :transaction_id,
             :processed_at, :created_at, :updated_at
end
