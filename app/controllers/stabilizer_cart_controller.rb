class StabilizerCartController < ApplicationController

  

  def remove_alt_from_cart
    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    @stabilizers = fetch_products
    @stabilizer = @stabilizer.find {|a| a.id == params[:stabilizer_id]}

    order_item = OrderItem.find_by order_id: order.id, stabilizer_id: @stabilizer.id
    order_item.destroy

    redirect_to cart_path
  end
end
