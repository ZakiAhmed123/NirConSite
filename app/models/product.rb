class Product < ActiveRecord::Base
   has_many :order_items
validates :name, :img_file, :price, :shipping_cost, :stud_dimensions, :stud_count, :total_weight, presence: true
end
