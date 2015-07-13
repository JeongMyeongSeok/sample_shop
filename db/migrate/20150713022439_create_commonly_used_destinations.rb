class CreateCommonlyUsedDestinations < ActiveRecord::Migration
  def change
    create_table :commonly_used_destinations do |t|
      t.integer :user_id, null: false
      t.string :name,     null: false
      t.string :address,  null: false
      t.integer :phone,   null: false

      t.timestamps null: false
    end
    add_index :commonly_used_destinations, :user_id
  end
end
