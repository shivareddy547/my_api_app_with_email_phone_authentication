class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.decimal :price
      t.string :category
      t.text :description
      t.boolean :available
      t.text :image
      t.integer :user_id

      t.timestamps
    end
    add_index :menu_items, :user_id
  end
end