class AddLengthToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :length, :integer
  end
end
