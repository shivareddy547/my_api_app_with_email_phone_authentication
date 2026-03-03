class AddOrderTypeTableIdCustomerNameFloorIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_type, :string
    add_column :orders, :table_id, :integer
    add_column :orders, :customer_name, :string
    add_column :orders, :floor_id, :integer
  end
end