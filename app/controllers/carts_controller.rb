class CartsController < ApplicationController

  def remove_from_cart
    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    @product = Product.find_by id: params[:product_id]

    order_item = OrderItem.find_by order_id: order.id, product_id: @product.id
    order_item.destroy

    redirect_to cart_path
  end

  def add_to_cart
    @product = Product.find_by id: params[:product_id]

    order = Order.find_by status: 'cart', user_id: current_or_guest_user.id

    if order.nil?
      order = Order.new
      order.user = current_or_guest_user
      order.purchased_at = Time.now
      order.save!
    end
    order_item = OrderItem.find_by order_id: order.id, product_id: @product.id

      order_item = OrderItem.new(orderitem_params)
      order_item.order = order
      order_item.product = @product
      order_item.price = @product.price
      order_item.shipping_cost = @product.shipping_cost
      order_item.img_file = @product.img_file
      order_item.name = @product.name

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



  def view
    @current_user=current_or_guest_user
    @order = Order.find_by status: 'cart', user_id: current_or_guest_user.id
    if @order.nil?
      @order=Order.new
    end
  end


  private
  def orderitem_params
    params.require(:order_item).permit(:quantity)
  end



end
