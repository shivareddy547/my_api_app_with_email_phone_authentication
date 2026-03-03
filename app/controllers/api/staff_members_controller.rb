module Api
  class StaffMembersController < ApplicationController
    before_action :set_staff_member, only: [:show, :update, :destroy, :status]

    # GET /api/staff
    def index
      @staff_members = current_user.staff_members
      @staff_members = @staff_members.where(role: params[:role]) if params[:role].present?
      render json: @staff_members, status: :ok
    end

    # POST /api/staff
    def create
      @staff_member = current_user.staff_members.new(staff_member_params)
      if @staff_member.save
        render json: @staff_member, status: :created
      else
        render json: { errors: @staff_member.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # GET /api/staff/:id
    def show
      render json: @staff_member, status: :ok
    end

    # PUT/PATCH /api/staff/:id
    def update
      if @staff_member.update(staff_member_params)
        render json: @staff_member, status: :ok
      else
        render json: { errors: @staff_member.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/staff/:id
    def destroy
      @staff_member.destroy
      head :no_content
    end

    # PATCH /api/staff/:id/status
    def status
      if @staff_member.update(status_params)
        render json: @staff_member, status: :ok
      else
        render json: { errors: @staff_member.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_staff_member
      @staff_member = current_user.staff_members.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Staff member not found" }, status: :not_found
    end

    def staff_member_params
      params.require(:staff_member).permit(:name, :role, :email, :phone, :status)
    end

    def status_params
      params.require(:staff_member).permit(:status)
    end
  end
end
