class AddUserIdToFloors < ActiveRecord::Migration[7.0]
  def change
    add_column :floors, :user_id, :integer
  end
end