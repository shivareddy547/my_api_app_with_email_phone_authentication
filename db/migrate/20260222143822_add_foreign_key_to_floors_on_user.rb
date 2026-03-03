class AddForeignKeyToFloorsOnUser < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :floors, :users, column: :user_id
  end
end