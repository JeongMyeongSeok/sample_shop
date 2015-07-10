class CreateCartDetails < ActiveRecord::Migration
  def change
    create_table :cart_details do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :price
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :cart_details, [:user_id, :product_id], unique: true
  end
end
