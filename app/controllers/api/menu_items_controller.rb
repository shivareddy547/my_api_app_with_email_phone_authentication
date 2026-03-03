# Controller for managing menu items (user scoped)
module Api
  class MenuItemsController < ApplicationController
    before_action :set_menu_item, only: [:update, :destroy, :availability]

    # GET /api/menu_items
    def index
      menu_items = current_user.menu_items
      render json: menu_items, each_serializer: MenuItemSerializer, status: :ok
    end

    # POST /api/menu_items
    def create
      menu_item = current_user.menu_items.new(menu_item_params)
      if menu_item.save
        render json: menu_item, serializer: MenuItemSerializer, status: :created
      else
        render json: { errors: menu_item.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PUT /api/menu_items/:id
    def update
      if @menu_item.update(menu_item_params)
        render json: @menu_item, serializer: MenuItemSerializer, status: :ok
      else
        render json: { errors: @menu_item.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/menu_items/:id
    def destroy
      @menu_item.destroy
      head :no_content
    end

    # PATCH /api/menu_items/:id/availability
    def availability
      if @menu_item.update(available: params[:available])
        render json: @menu_item, serializer: MenuItemSerializer, status: :ok
      else
        render json: { errors: @menu_item.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_menu_item
      @menu_item = current_user.menu_items.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Menu item not found" }, status: :not_found
    end

    def menu_item_params
      params.require(:menu_item).permit(
        :name,
        :price,
        :category,
        :description,
        :available,
        :image
      )
    end
  end
end
