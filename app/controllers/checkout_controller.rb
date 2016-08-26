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

    @order.save!

    EasyPost.api_key = 's7GSYnjCSu0HWkp5PE5akg'

      to_address = EasyPost::Address.create(
    :name =>  @order.name,
    :street1 => @order.address_line1,
    :city => @order.address_city,
    :state => @order.address_state,
    :zip => @order.address_zip,
    :country => 'US',
    :phone => @order.phone_number
  )
  from_address = EasyPost::Address.create(
    :company => 'Nirvana Products',
    :street1 => '12029 Brittmoore Park Drive',
    :city => 'Houston',
    :state => 'TX',
    :zip => '77041',
    :phone => '832-277-6945'
  )

  parcel = EasyPost::Parcel.create(
    :width => 15.2,
    :length => 18,
    :height => 9.5,
    :weight => 35.1
  )


  shipment = EasyPost::Shipment.create(
    :to_address => to_address,
    :from_address => from_address,
    :parcel => parcel,
  )

  shipment.buy(
    :rate => shipment.lowest_rate
  )

  shipment.insure(amount: 100)


  puts shipment.lowest_rate.rate
  puts shipment.insurance

  puts shipment.postage_label.label_url
  @order.shipping_cost = shipment.lowest_rate.rate.to_i.round
  @order.save!
    redirect_to checkout_path
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
      :amount => @order.total_price_in_cents,
      :currency => "usd",
      :source => card_token,
    )



    if @order.update status: 'pending'
    ReceiptMailer.order_confirmation(@user, @order).deliver
    redirect_to receipt_path(id: @order.id)
    else
    render :new
    

    end

 # if @order.update status: 'pending'
 #   ReceiptMailer.order_confirmation(@user, @order).deliver
 #
 # else
 #   redirect_to request.referrer, alert: "Transaction Failed to Process, Please Try Again and Validate your card information"
 # end

end

  def receipt
    @order = Order.find_by! id: params[:id], user_id: current_or_guest_user.id
  end

  private
    def order_params
      params.require(:orders).permit(:address_zip, :address_city, :address_state, :address_line1, :phone_number, :name, :shipping_cost)
    end
end
