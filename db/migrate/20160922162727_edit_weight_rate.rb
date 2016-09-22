class EditWeightRate < ActiveRecord::Migration
  def change
    remove_column :products, :weight_rate
    add_column :products, :ppf, :decimal
  end
end
