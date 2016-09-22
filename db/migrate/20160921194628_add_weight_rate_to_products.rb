class AddWeightRateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :weight_rate, :integer
  end
end
