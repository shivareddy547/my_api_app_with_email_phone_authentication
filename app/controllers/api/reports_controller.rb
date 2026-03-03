# Backend file for user 1, project my_api_app_with_email_phone_authentication
# Path: app/controllers/api/reports_controller.rb
# Controller for Reports API endpoints
module Api
  class ReportsController < ApplicationController
    before_action :validate_period, only: [:stats, :top_items, :recent_orders, :hourly_sales]

    VALID_PERIODS = %w[today week month year].freeze

    # GET /api/reports
    def index
      period = params[:period] || 'today'
      unless VALID_PERIODS.include?(period)
        return render json: { success: false, error: "Invalid period parameter" }, status: :bad_request
      end
      
      data = {
        stats: calculate_stats(period),
        top_items: fetch_top_items(period, 5),
        recent_orders: fetch_recent_orders(period, 10)
      }
      
      render json: { success: true, data: data }, status: :ok
    end

    # GET /api/reports/stats
    def stats
      data = calculate_stats(params[:period])
      render json: { success: true, data: data }, status: :ok
    end

    # GET /api/reports/top-items
    def top_items
      limit = (params[:limit] || 5).to_i
      data = fetch_top_items(params[:period], limit)
      render json: { success: true, data: data }, status: :ok
    end

    # GET /api/reports/recent-orders
    def recent_orders
      limit = (params[:limit] || 10).to_i
      data = fetch_recent_orders(params[:period], limit)
      render json: { success: true, data: data }, status: :ok
    end

    # GET /api/reports/hourly-sales
    def hourly_sales
      data = fetch_hourly_sales(params[:period], params[:date])
      render json: { success: true, data: data }, status: :ok
    rescue ArgumentError
      render json: { success: false, error: "Invalid date format" }, status: :bad_request
    end

    private

    def validate_period
      unless VALID_PERIODS.include?(params[:period])
        render json: { success: false, error: "Invalid period parameter" }, status: :bad_request
      end
    end

    def calculate_stats(period)
      orders = orders_for_period(period)
      total_revenue = orders.sum(:total) || 0
      total_orders = orders.count
      average_order = total_orders > 0 ? (total_revenue / total_orders).round(2) : 0
      active_customers = orders.where.not(table_id: nil).distinct.count(:table_id)

      previous_orders = orders_for_previous_period(period)
      previous_revenue = previous_orders.sum(:total) || 0
      previous_orders_count = previous_orders.count

      {
        totalRevenue: total_revenue.to_f.round(2),
        totalOrders: total_orders,
        averageOrder: average_order,
        activeCustomers: active_customers,
        revenueChange: calculate_percentage_change(total_revenue, previous_revenue),
        ordersChange: calculate_percentage_change(total_orders, previous_orders_count),
        avgOrderChange: calculate_avg_order_change(orders, previous_orders),
        customersChange: calculate_customers_change(orders, previous_orders)
      }
    end

    def fetch_top_items(period, limit)
      menu_items = MenuItem.joins(order_items: :order)
                           .where(orders: { created_at: period_range(period) })
                           .group('menu_items.id')
                           .order('SUM(order_items.quantity) DESC')
                           .limit(limit)

      menu_items.map do |item|
        orders_count = OrderItem.where(menu_item_id: item.id)
                                .joins(:order)
                                .where(orders: { created_at: period_range(period) })
                                .sum(:quantity)
        revenue = OrderItem.where(menu_item_id: item.id)
                           .joins(:order)
                           .where(orders: { created_at: period_range(period) })
                           .sum('order_items.quantity * COALESCE(order_items.unit_price, 0)')
        {
          id: item.id,
          name: item.name,
          orders: orders_count.to_i,
          revenue: revenue.to_f.round(2)
        }
      end
    end

    def fetch_recent_orders(period, limit)
      orders = current_user.orders.where(created_at: period_range(period))
                    .order(created_at: :desc)
                    .limit(limit)

      orders.map do |order|
        {
          id: order.id,
          table: order.table_id.present? ? "Table #{order.table_id}" : "N/A",
          amount: order.total.to_f.round(2),
          time: order.created_at.strftime("%I:%M %p"),
          status: order.status
        }
      end
    end

    def fetch_hourly_sales(period, specific_date)
      target_date = specific_date ? Date.parse(specific_date) : Date.current

      hourly_data = (9..22).map do |hour|
        revenue = current_user.orders.where(created_at: target_date.beginning_of_day..target_date.end_of_day)
                       .where("EXTRACT(HOUR FROM created_at) = ?", hour)
                       .sum(:total)
        { hour: hour, revenue: revenue.to_f.round(2) }
      end

      {
        date: target_date.to_s,
        hourlyData: hourly_data
      }
    end

    def period_range(period)
      case period
      when 'today'
        Date.current.beginning_of_day..Date.current.end_of_day
      when 'week'
        1.week.ago.beginning_of_day..Time.current
      when 'month'
        1.month.ago.beginning_of_day..Time.current
      when 'year'
        1.year.ago.beginning_of_day..Time.current
      end
    end

    def orders_for_period(period)
      current_user.orders.where(created_at: period_range(period))
    end

    def orders_for_previous_period(period)
      case period
      when 'today'
        current_user.orders.where(created_at: 1.day.ago.beginning_of_day..1.day.ago.end_of_day)
      when 'week'
        current_user.orders.where(created_at: 2.weeks.ago.beginning_of_day..1.week.ago.end_of_day)
      when 'month'
        current_user.orders.where(created_at: 2.months.ago.beginning_of_day..1.month.ago.end_of_day)
      when 'year'
        current_user.orders.where(created_at: 2.years.ago.beginning_of_day..1.year.ago.end_of_day)
      end
    end

    def calculate_percentage_change(current, previous)
      return 0 if previous.zero?
      ((current - previous).to_f / previous * 100).round(1)
    end

    def calculate_avg_order_change(orders, previous_orders)
      current_avg = orders.count > 0 ? orders.sum(:total) / orders.count : 0
      previous_avg = previous_orders.count > 0 ? previous_orders.sum(:total) / previous_orders.count : 0
      calculate_percentage_change(current_avg, previous_avg)
    end

    def calculate_customers_change(orders, previous_orders)
      current_customers = orders.where.not(table_id: nil).distinct.count(:table_id)
      previous_customers = previous_orders.where.not(table_id: nil).distinct.count(:table_id)
      calculate_percentage_change(current_customers, previous_customers)
    end
  end
end
