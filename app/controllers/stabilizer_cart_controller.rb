class StabilizerCartController < ApplicationController

  def add_stabilizers
    @stabilizers = fetch_stabilizers
    @stabilizer = @stabilizers.find {|a| a.id == params[:stabilizer_id]}

    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    if order.nil?
      order = Order.new
      order.user = current_or_guest_user
      order.purchased_at = Time.now
      order.save!
    end
    order_item = OrderItem.find_by order_id: order.id, stabilizer_id: @stabilizer.id

      order_item = OrderItem.new(orderitem_params)
      order_item.order = order
      order_item.product = @stabilizer
      order_item.price = @stabilizer.price
      order_item.shipping_cost = @stabilizer.shipping_cost
      order_item.img_file = @stabilizer.img_file
      order_item.name = @stabilizer.name

      if order_item.quantity.blank?
        order_item.quantity=1
      end
    if order_item.save!
      flash[:success] = "Successfully Added to Cart"
      redirect_to request.referrer
    else
      flash[:error] = "Error In adding to Cart"
      render :new
      end
  end


  def remove_alt_from_cart
    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    @stabilizers = fetch_products
    @stabilizer = @stabilizer.find {|a| a.id == params[:stabilizer_id]}

    order_item = OrderItem.find_by order_id: order.id, stabilizer_id: @stabilizer.id
    order_item.destroy

    redirect_to cart_path
  end
end
