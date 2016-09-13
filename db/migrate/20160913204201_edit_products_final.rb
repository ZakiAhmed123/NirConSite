class EditProductsFinal < ActiveRecord::Migration
  def change
    remove_column :products, :length
    remove_column :products, :width
    remove_column :products, :thickness
    remove_column :products, :stud_length
    remove_column :products, :stud_thickness
    add_column :products, :stud_dimensions, :string
  end
end
