

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :table, optional: true
  belongs_to :floor, optional: true
  has_many :order_items, class_name: 'OrderItem'
  accepts_nested_attributes_for :order_items

  # Callback to update table status when order status changes
  after_commit :update_table_status_based_on_order, on: [:create, :update]

  private

  def update_table_status_based_on_order
    return unless table_id

    # Define statuses that consider an order "active" vs "terminal"
    # Adjust these statuses based on your actual business logic
    active_statuses = ['pending', 'confirmed', 'preparing', 'ready', 'served', 'paid']
    terminal_statuses = ['completed', 'cancelled','paid']

    if active_statuses.include?(status)
      # Mark table as occupied if order is active
      table.update(status: 'occupied')
    elsif terminal_statuses.include?(status)
      # Free up the table if order is finished
      table.update(status: 'available', order_id: nil, waiter: nil, time_seated: nil, total: nil)
    end
  end
end