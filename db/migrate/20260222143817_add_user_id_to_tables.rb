class AddUserIdToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :tables, :user_id, :integer
  end
end