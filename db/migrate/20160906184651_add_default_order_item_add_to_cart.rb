class AddDefaultOrderItemAddToCart < ActiveRecord::Migration
  def change
    change_column_default(:order_items, :quantity, 1)
  end
end
