class AddLengthInchesToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :length_inch, :integer
  end
end
