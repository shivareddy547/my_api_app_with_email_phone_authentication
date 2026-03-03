class CreateStaffMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :staff_members do |t|
      t.string :name
      t.string :role
      t.string :email
      t.string :phone
      t.string :status
      t.string :avatar

      t.timestamps
    end
  end
end