class CartsController < ApplicationController

  def remove_from_cart
    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    @products = fetch_products
    @product = @products.find {|a| a.id == params[:product_id]}

    order_item = OrderItem.find_by order_id: order.id, product_id: @product.id
    order_item.destroy

    redirect_to cart_path
  end

  def add_to_cart
    @products = fetch_products
    @product = @products.find {|a| a.id == params[:product_id]}

    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    if order.nil?
      order = Order.new
      order.user = current_or_guest_user
      order.purchased_at = Time.now
      order.save!
    end

    order_item = OrderItem.find_by order_id: order.id, product_id: @product.id
    if order_item.present?
      order_item.quantity = order_item.quantity + 1
    else
      order_item = OrderItem.new(orderitem_params)
      order_item.order = order
      order_item.product = @product
      order_item.price = @product.price
      order_item.shipping_cost = @product.shipping_cost
      order_item.img_file = @product.img_file
    end
    order_item.save!

    redirect_to request.referrer

  end

  def view
    @current_user=current_or_guest_user
    @order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

  end

  def add_to_cart_stabilizer
    @stabilizers= fetch_stabilizers
    @stabilizer = @stabilizers.find {|a| a.id == params[:id]}

    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    if order.nil?
      order = Order.new
      order.user = current_or_guest_user
      order.purchased_at = Time.now
      order.save!
    end

    order_item = OrderItem.find_by order_id: order.id, product_id: @stabilizer.id
    if order_item.present?
      order_item.quantity = order_item.quantity + 1
    else
      order_item = OrderItem.new
      order_item.order = order
      order_item.product = @stabilizer
      order_item.price = @stabilizer.price
      order_item.shipping_cost = @stabilizer.shipping_cost
      order_item.quantity = 1
      order_item.img_file = @stabilizer.img_file
    end
    order_item.save!

    redirect_to request.referrer

  end

  def remove_from_cart_stabilizer
    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    @stabilizers= fetch_stabilizers
    @stabilizer = @stabilizers.find {|a| a.id == params[:id]}

    order_item = OrderItem.find_by order_id: order.id, product_id: @stabilizer.id
    order_item.destroy

    redirect_to cart_path
  end

  private
  def orderitem_params
    params.permit(:quantity)
  end

end
