class AddUserIdToStaffMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :staff_members, :user_id, :integer
  end
end