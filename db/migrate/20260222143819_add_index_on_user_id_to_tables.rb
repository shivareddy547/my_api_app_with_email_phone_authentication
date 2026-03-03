class AddIndexOnUserIdToTables < ActiveRecord::Migration[7.0]
  def change
    add_index :tables, :user_id
  end
end