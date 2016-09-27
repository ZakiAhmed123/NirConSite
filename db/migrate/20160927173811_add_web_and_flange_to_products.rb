class AddWebAndFlangeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :web, :decimal
    add_column :products, :flange, :decimal
  end
end
