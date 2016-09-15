class RemoveStatusFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :status
    remove_column :order_items, :shipped
    remove_column :orders, :address_same
    drop_table :stabilizers
  end
end
