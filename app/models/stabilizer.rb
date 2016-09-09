class Stabilizer < ActiveRecord::Base
  has_many :order_items
  attr_accessor :id,:name, :shipping_cost, :price,:img_file, :pdf, :subtitle
end
