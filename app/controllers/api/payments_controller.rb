# Controller for processing payments (user scoped)
module Api
  class PaymentsController < ApplicationController
    # POST /api/payments/process
    def process_payment
      payment = current_user.payments.new(payment_params)
      if payment.save
        render json: payment, serializer: PaymentSerializer, status: :created
      else
        render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def payment_params
      params.require(:payment).permit(
        :order_id,
        :amount,
        :currency,
        :payment_method,
        :payment_provider,
        :status,
        :transaction_id,
        :processed_at
      )
    end
  end
end
