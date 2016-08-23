class AddNameAndBooleanToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :address_same, :boolean, default: false
  end
end
