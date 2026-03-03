# Backend file for user 1, project my_api_app_with_email_phone_authentication
# Path: app/controllers/api/orders_controller.rb
module Api
  class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :status, :update]

    # POST /api/orders
    def create
      # Map incoming items param to nested order_items_attributes
      # We transform the input hash to match the model expectations.
      # 'id' in items corresponds to 'menu_item_id' in OrderItem.
      # We remove 'price', 'name', 'category' as they are not attributes on OrderItem model.
      if params[:order][:items].present?
        params[:order][:order_items_attributes] = params[:order][:items].map do |item|
          {
            menu_item_id: item[:id],
            quantity: item[:quantity],
            unit_price: (item[:unit_price] || item[:price])
          }
        end
        params[:order].delete(:items)
      end

      order = current_user.orders.new(order_params)
      if order.save
        render json: order, serializer: OrderSerializer, status: :created
      else
        render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # GET /api/orders/:id
    def show
      render json: @order, serializer: OrderSerializer, status: :ok
    end

    # GET /api/orders
    def index
      orders = current_user.orders.includes(:order_items, :table, :floor)
      render json: orders, each_serializer: OrderSerializer, status: :ok
    end

    # PATCH /api/orders/:id/status
    def status
      if @order.update(status: params[:status])
        render json: @order, serializer: OrderSerializer, status: :ok
      else
        render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH /api/orders/:id
    def update
      if @order.update(order_params)
        render json: @order, serializer: OrderSerializer, status: :ok
      else
        render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_order
      # Eager load associations to prevent N+1 queries in serialization
      @order = current_user.orders.includes(:order_items, :table, :floor).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Order not found" }, status: :not_found
    end

    def order_params
      params.require(:order).permit(
        :subtotal,
        :tax,
        :total,
        :status,
        :payment_method,
        :order_type,
        :table_id,
        :customer_name,
        :floor_id,
        # Removed :price to fix ActiveModel::UnknownAttributeError
        order_items_attributes: [:menu_item_id, :quantity,:unit_price,:price]

      )
    end
  end
end
