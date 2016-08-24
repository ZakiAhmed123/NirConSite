class ChangeShippingCostDefault < ActiveRecord::Migration
  def change
    change_column_default(:orders, :shipping_cost, 1)
  end
end
