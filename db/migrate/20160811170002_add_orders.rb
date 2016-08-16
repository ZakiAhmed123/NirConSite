class AddOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.datetime :purchased_at
      t.string :status, default: "cart"
      t.timestamps null: false
    end
  end
end
