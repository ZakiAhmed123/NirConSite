class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  def subtotal
    order_items.map { |order_item| order_item.subtotal_price}.sum
  end

  def total_tax
    order_items.map { |order_item| order_item.tax_price }.sum
  end

  def total_price
    order_items.map { |order_item| order_item.item_price }.sum + shipping_cost
  end

  def total_price_texas
    order_items.map { |order_item| order_item.total_price_texas }.sum + shipping_cost
  end

  def total_price_in_cents
    (total_price * 100).to_i
end

end
