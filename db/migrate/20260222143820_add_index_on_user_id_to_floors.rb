class AddIndexOnUserIdToFloors < ActiveRecord::Migration[7.0]
  def change
    add_index :floors, :user_id
  end
end