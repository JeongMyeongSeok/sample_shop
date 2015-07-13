class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :price
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :order_details, [:order_id, :product_id], unique: true
  end
end
