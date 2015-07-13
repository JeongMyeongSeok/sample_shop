class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.integer :order_id,   null: false
      t.integer :product_id, null: false
      t.integer :price,      null: false
      t.integer :quantity,   null: false

      t.timestamps null: false
    end
    add_index :order_details, [:order_id, :product_id], unique: true
  end
end
