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

    if order_item.present?
      order_item.increment :quantity
    else
      order_item = OrderItem.new(orderitem_params)
      order_item.order = order
      order_item.product = @product
      if @product.category == "Stud"
        if order_item.length.nil?
          order_item.length=1
        end
        if order_item.length_inch.nil?
          order_item.length_inch=1
        end
      order_item.price = (@product.ppf * order_item.length) + (@product.ppi * order_item.length_inch)
      elsif @product.category == "Track"
      order_item.price = (@product.ppf * order_item.length) + (@product.ppi * order_item.length_inch)
      else
      order_item.price = @product.price
      end
      order_item.shipping_cost = @product.shipping_cost
      order_item.img_file = @product.img_file
      order_item.name = @product.name
    end

     if order_item.quantity.blank?
       order_item.quantity=1
     end

      if order_item.length.blank?
        order_item.length = 1
      end
    if order_item.save!
      flash[:success] = "Successfully Added to Cart"
      redirect_to request.referrer
    else
      flash[:error] = "Quantity Cannot be Blank"
      redirect_to request.referrer
      end
  end

  def view
    @order = Order.find_by status: 'cart', user_id: current_or_guest_user.id
    if @order.nil?
      @order=Order.new
    end
  end

  private
  def orderitem_params
    params.require(:order_item).permit(:quantity, :length, :length_inch, :dimple)
  end

end
