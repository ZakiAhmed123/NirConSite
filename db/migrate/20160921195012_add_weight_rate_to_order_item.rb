class AddWeightRateToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :weight_rate, :integer
  end
end
