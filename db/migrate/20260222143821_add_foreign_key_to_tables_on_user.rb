class AddForeignKeyToTablesOnUser < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :tables, :users, column: :user_id
  end
end