class OrdersController < ApplicationController

  def index
  @orders = Order.where('(status= ? AND user_id= ?) OR (status= ? AND user_id= ?)', 'pending', current_or_guest_user.id,'complete',current_or_guest_user.id)
  end

  def view
  @order = Order.find_by id: params[:id]
  end
end
