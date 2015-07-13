class CreateCommonlyUsedDestinations < ActiveRecord::Migration
  def change
    create_table :commonly_used_destinations do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.integer :phone

      t.timestamps null: false
    end
    add_index :commonly_used_destinations, :user_id
  end
end
