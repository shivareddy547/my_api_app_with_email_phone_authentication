class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.decimal :amount
      t.string :currency
      t.string :payment_method
      t.string :payment_provider
      t.string :status
      t.string :transaction_id
      t.datetime :processed_at
      t.integer :user_id

      t.timestamps
    end
    add_index :payments, :user_id
    add_index :payments, :order_id
  end
end