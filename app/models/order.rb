class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user
attr_writer :current_step
validates_presence_of :address_line1, :address_state, :address_city,:address_zip, :email,:phone_number, :if => lambda { |o| o.current_step == "shipping"}
validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def subtotal
    order_items.map { |order_item| order_item.item_price}.sum
  end

  def total_tax
    order_items.map { |order_item| order_item.tax_price }.sum
  end

  def cart_total
    subtotal + total_shipping
  end

  def total_shipping
    order_items.map{ |order_item| order_item.item_shipping_price }.sum
  end

  def total_price
    order_items.map { |order_item| order_item.item_price }.sum + total_shipping
  end

  def total_price_texas
    order_items.map { |order_item| order_item.total_item_price_texas }.sum + total_shipping
  end

  def total_price_in_cents
    (total_price * 100).to_i
  end

  def total_price_in_cents_texas
    (total_price_texas * 100).to_i
  end

  def final_price
    if address_state = "TX"
      (total_price_texas * 100).to_i
    else
      (total_price * 100).to_i
  end
  end

def current_step
  @current_step || steps.first
end
def steps
  %w[shipping payment]
end
def next_step
self.current_step = steps[steps.index(current_step)+1]
end

def next_step
self.current_step = steps[steps.index(current_step)-1]
end

def first_step?
  current_step == steps.first
end



end
