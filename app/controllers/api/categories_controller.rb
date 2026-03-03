# Controller for managing categories (user scoped)
module Api
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:destroy]

    # GET /api/categories
    def index
      categories = current_user.categories
      render json: categories, each_serializer: CategorySerializer, status: :ok
    end

    # POST /api/categories
    def create
      category = current_user.categories.new(category_params)
      if category.save
        render json: category, serializer: CategorySerializer, status: :created
      else
        render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/categories/:id
    def destroy
      if @category.menu_items.exists?
        render json: { error: "Cannot delete category with associated menu items" }, status: :bad_request
      else
        @category.destroy
        head :no_content
      end
    end

    private

    def set_category
      @category = current_user.categories.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Category not found" }, status: :not_found
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
end
