class Product < ActiveRecord::Base
   has_many :order_items
validates :name, :img_file, :price, :shipping_cost, :info_1, :info_2, :info_3, presence: true
end
