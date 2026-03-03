class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.integer :floor_id
      t.string :number
      t.integer :capacity
      t.string :status
      t.integer :order_id
      t.string :waiter
      t.datetime :time_seated
      t.decimal :total

      t.timestamps
    end
    add_index :tables, :floor_id
    add_index :tables, :order_id
  end
end