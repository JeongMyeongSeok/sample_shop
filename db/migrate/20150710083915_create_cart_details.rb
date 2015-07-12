class CreateCartDetails < ActiveRecord::Migration
  def change
    create_table :cart_details do |t|
      t.integer :user_id,     null: false
      t.integer :product_id,  null: false
      t.integer :price,       null: false
      t.integer :quantity,    null: false

      t.timestamps null: false
    end
    add_index :cart_details, [:user_id, :product_id], unique: true
  end
end
