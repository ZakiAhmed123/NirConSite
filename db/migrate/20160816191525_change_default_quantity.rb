class ChangeDefaultQuantity < ActiveRecord::Migration
  def change
    change_column_default(:order_items, :quantity, nil)
  end
end
