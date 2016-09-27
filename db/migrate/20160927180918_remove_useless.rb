class RemoveUseless < ActiveRecord::Migration
  def change
    remove_column :order_items, :weight_rate
  end
end
