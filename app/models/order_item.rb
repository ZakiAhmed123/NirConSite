class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def total_price
    quantity * (price + shipping_cost)
  end

  def subtotal_price
    quantity * price
  end

  def total_shipping
    quantity * shipping_cost
  end
end
