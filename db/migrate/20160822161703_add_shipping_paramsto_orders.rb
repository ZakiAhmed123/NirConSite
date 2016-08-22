class AddShippingParamstoOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address_line1, :text
    add_column :orders, :address_city, :string
    add_column :orders, :address_state, :string
    add_column :orders, :address_zip, :string
  end
end
