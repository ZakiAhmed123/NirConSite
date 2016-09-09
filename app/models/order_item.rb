class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :stabilizer

  def total_item_price_texas
    quantity * price * 1.0825
  end

  def item_price
    quantity * price
  end

  def tax_price
    ((quantity * price) * 0.0825)
  end

  def item_shipping_price
    shipping_cost * quantity
  end




end
