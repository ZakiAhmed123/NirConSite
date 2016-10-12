class CheckoutController < ApplicationController
  include Wicked::Wizard
  steps :process_shipping
  before_action do
        if current_or_guest_user.nil?
          redirect_to sign_in_path
        end
      end
      def cart_view
        @order = Order.find_by status: 'cart', user_id: current_or_guest_user.id
        if @order.nil?
          @order=Order.new
        end
      end
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
          if @product.info_1.include? "flange"
            if order_item.length.nil?
              order_item.length=1
            end
            if order_item.length_inch.nil?
              order_item.length_inch=1
            end
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
          flash[:error] = "Error In adding to Cart"
          render :new
          end
      end





  def shipping
    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id
  end

  def process_shipping
    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id
    @order.update_attributes(order_params)
    if @order.save
    redirect_to checkout_path
  else
    flash[:error] = "Error In Shipping Address: Verify All Entries Are Filled in"
    redirect_to shipping_path
  end
end

  def payment
    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id
  end

  def process_payment

    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id
    @user = current_or_guest_user


    card_token = params[:stripeToken]

    Stripe.api_key = "sk_live_rBUFnaNVloLy6YhyhEDJx5O4"

    Stripe::Charge.create(
      :amount => @order.final_price,
      :currency => "usd",
      :source => card_token,
    )


    if @order.email.present?
    @order.update status: 'pending'
    ReceiptMailer.order_confirmation(@user, @order).deliver_now
    redirect_to receipt_path(id: @order.id)
    else
      @order.update status: 'pending'
      redirect_to receipt_path(id: @order.id)
    end

  end

  def receipt
    @order = Order.find_by! id: params[:id], user_id: current_or_guest_user.id
  end

  private
    def order_params
      params.require(:orders).permit(:address_zip, :address_city, :address_state, :address_line1, :phone_number, :name, :shipping_cost, :email)
    end

    private
    def orderitem_params
      params.require(:order_item).permit(:quantity, :length, :length_inch, :dimple)
    end
end
