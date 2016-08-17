class CheckoutController < ApplicationController
  before_action do
        if current_or_guest_user.nil?
          redirect_to sign_in_path
        end
      end

  def start

    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id
  end

  def process_payment
    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id

    # process the payment

    # Actually process payment
    # card_token = params[:token]
    card_token = params[:stripeToken] # how stripe checkout tells me

    Stripe.api_key = "sk_test_xIGhTi9JGwC0H65Tq1KdFEJE"

    customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source => card_token
    )

    Stripe::Charge.create(
      :customer => customer.id,
      :amount => @order.total_price_in_cents,
      :currency => "usd",
      :source => card_token,
      :description => @order.description
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to checkout_path

 #    rescue Stripe::CardError => e
 # # Since it's a decline, Stripe::CardError will be caught
 #  body = e.json_body
 #  err  = body[:error]
 #
 #  @logger.error "Status is: #{e.http_status}"
 #  @logger.error "Type is: #{err[:type]}"
 #  @logger.error "Code is: #{err[:code]}"
 # # param is '' in this case
 #  @logger.error "Param is: #{err[:param]}"
 #  @logger.error "Message is: #{err[:message]}"
 #
 #  raise Striped::CreditCardDeclined.new(err[:message])
 #  rescue Exception => ex
 #    @logger.error "Purchase failed due to : #{ex.message}"
 #
 #    raise
 #
 #    # if successful, redirect
 #    # else show start

 if @order.update status: 'pending'
   ReceiptMailer.order_confirmation(current_user, @order).deliver
   redirect_to receipt_path(id: @order.id)
 else
   redirect_to request.referrer, alert: "Transaction Failed to Process, Please Try Again and Validate your card information"
 end

end

  def receipt
    # I want a 404 if we can't find_by
    @order = Order.find_by! id: params[:id], user_id: current_or_guest_user.id
  end
end
