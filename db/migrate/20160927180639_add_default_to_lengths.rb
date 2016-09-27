class AddDefaultToLengths < ActiveRecord::Migration
  def change
    change_column_default :order_items, :length, 1
    change_column_default :order_items, :length_inch, 0
  end
end
