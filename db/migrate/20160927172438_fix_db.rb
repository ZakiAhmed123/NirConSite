class FixDb < ActiveRecord::Migration
  def change
    remove_column :products, :stud_dimensions
    remove_column :products, :stud_count
    remove_column :products, :total_weight
    add_column :products, :info_1, :string
    add_column :products, :info_2, :string
    add_column :products, :info_3, :string
  end
end
