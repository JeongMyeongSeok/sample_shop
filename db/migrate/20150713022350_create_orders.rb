class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.string :name,     null: false
      t.string :address,  null: false
      t.string :phone,   null: false

      t.timestamps null: false
    end
    add_index :orders, :user_id
  end
end
