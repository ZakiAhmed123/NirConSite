class OrdersController < ApplicationController
  helper_method :current_or_guest_user

  def index
  @orders = Order.where("status != ?", 'cart').order("purchased_at desc")
  end

  def view
  @order = Order.find_by id: params[:id]
  end
end
