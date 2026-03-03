# Backend file for user 1, project my_api_app_with_email_phone_authentication
# Path: app/controllers/api/floors_controller.rb
# Controller for Floor management
# Model: Floor
module Api
  class FloorsController < ApplicationController
    before_action :set_floor, only: [:show, :update, :destroy]

    # GET /api/floors
    def index
      @floors = current_user.floors
      render json: @floors, each_serializer: FloorSerializer, status: :ok
    end

    # POST /api/floors
    def create
      @floor = current_user.floors.new(floor_params)
      if @floor.save
        render json: @floor, serializer: FloorSerializer, status: :created
      else
        render json: { errors: @floor.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # GET /api/floors/:id
    def show
      render json: @floor, serializer: FloorSerializer, status: :ok
    end

    # PATCH /api/floors/:id
    def update
      if @floor.update(floor_params)
        render json: @floor, serializer: FloorSerializer, status: :ok
      else
        render json: { errors: @floor.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/floors/:id
    def destroy
      @floor.destroy
      head :no_content
    end

    private

    def set_floor
      @floor = current_user.floors.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Floor not found" }, status: :not_found
    end

    def floor_params
      params.require(:floor).permit(:name)
    end
  end
end
