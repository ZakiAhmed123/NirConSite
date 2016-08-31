class CheckoutController < ApplicationController
  before_action do
        if current_or_guest_user.nil?
          redirect_to sign_in_path
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

    Stripe.api_key = "sk_test_xIGhTi9JGwC0H65Tq1KdFEJE"

    Stripe::Charge.create(
      :amount => @order.final_price,
      :currency => "usd",
      :source => card_token,
    )

    if @order.update status: 'pending'
    ReceiptMailer.order_confirmation(@user, @order).deliver_now
    redirect_to receipt_path(id: @order.id)
    else
    render :new
    end

  end

  def receipt
    @order = Order.find_by! id: params[:id], user_id: current_or_guest_user.id
  end

  private
    def order_params
      params.require(:orders).permit(:address_zip, :address_city, :address_state, :address_line1, :phone_number, :name, :shipping_cost, :email)
    end
end
