# Backend file for user 1, project my_api_app_with_email_phone_authentication
# Path: app/controllers/api/tables_controller.rb
# Controller for Table management within a Floor
# Model: Table
module Api
  class TablesController < ApplicationController

    before_action :set_floor, only: [:index, :create, :show, :update, :destroy, :start_order, :clear]
    before_action :set_table, only: [:show, :update, :destroy, :start_order, :clear]

    # GET /api/floors/:floor_id/tables
    def index
      @tables = @floor.tables
      render json: @tables, each_serializer: TableSerializer, status: :ok
    end

    # POST /api/floors/:floor_id/tables
    def create
      @table = @floor.tables.new(table_params)
      # Fix: Assign the current_user to the table to satisfy the "User must exist" validation
      @table.user = current_user
      if @table.save
        render json: @table, serializer: TableSerializer, status: :created
      else
        render json: { errors: @table.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # GET /api/floors/:floor_id/tables/:id
    def show
      render json: @table, serializer: TableSerializer, status: :ok
    end

    # PATCH /api/floors/:floor_id/tables/:id
    def update
      if @table.update(table_params)
        render json: @table, serializer: TableSerializer, status: :ok
      else
        render json: { errors: @table.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/floors/:floor_id/tables/:id
    def destroy
      @table.destroy
      head :no_content
    end

    # POST /api/floors/:floor_id/tables/:id/start_order
    def start_order
      if @table.update(status: 'occupied')
        render json: @table, serializer: TableSerializer, status: :ok
      else
        render json: { errors: @table.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH /api/floors/:floor_id/tables/:id/clear
    def clear
      if @table.update(status: 'available', order_id: nil, waiter: nil, time_seated: nil, total: nil)
        render json: @table, serializer: TableSerializer, status: :ok
      else
        render json: { errors: @table.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_floor
      @floor = current_user.floors.find(params[:floor_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Floor not found" }, status: :not_found
    end

    def set_table
      @table = @floor.tables.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Table not found" }, status: :not_found
    end

    def table_params
      params.require(:table).permit(
        :number,
        :capacity,
        :status,
        :order_id,
        :waiter,
        :time_seated,
        :total
      )
    end
  end
end
