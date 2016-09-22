class AddPpiToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ppi, :decimal
  end
end
