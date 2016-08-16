class Product < ActiveRecord::Base
   has_many :order_items
   attr_accessor :id,:pdf,:length,:width,:thickness,:stud_count,:stud_thickness,:stud_length,:total_weight,:pre_price,:shipping_cost,:price,:name,:img_file,:pdf

end
