class AddDimpleToProduct < ActiveRecord::Migration
  def change
    add_column :products, :dimple, :string
  end
end
