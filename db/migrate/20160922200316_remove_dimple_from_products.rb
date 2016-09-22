class RemoveDimpleFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :dimple
    add_column :order_items, :dimple, :string, default:'no'
  end
end
