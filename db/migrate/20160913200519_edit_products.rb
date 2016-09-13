class EditProducts < ActiveRecord::Migration
  def change
    remove_column :products, :quantity
    add_column :products, :length, :string
    add_column :products, :width, :string
    add_column :products, :thickness, :string
    add_column :products, :stud_count, :string
    add_column :products, :stud_thickness, :string
    add_column :products, :stud_length, :string
    add_column :products, :total_weight, :string
    add_column :products, :shipping_cost, :integer
    add_column :products, :price, :integer
    add_column :products, :name, :string
    add_column :products, :img_file, :string
  end
end
