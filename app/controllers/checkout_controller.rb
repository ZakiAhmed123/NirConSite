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

    Stripe::Charge.create(
      :amount => @order.total_price_in_cents,
      :currency => "usd",
      :source => card_token,
      :description => @order.description
    )

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

  if  @order.update status: 'pending'
    Shippo.api_key = '6ab6370046522ef5df151d5f5e4dc579d7f83606'

    params   = { object_purpose: 'PURCHASE',
              async:          false,
              address_from:   {
                object_purpose: 'PURCHASE',
                name:           'NIRVANA PRODUCTS LLC',
                company:        'NIRVANA PRODUCTS LLC',
                street1:        '14025 West Road',
                street2:        '',
                city:           'Houston',
                state:          'TX',
                zip:            '77041',
                country:        'US',
                phone:          '+1 832 277 6945',
                email:          'zakinircon@gmail.com' },
              address_to:     {
                object_purpose: 'PURCHASE',
                name:           :stripeBillingName,
                company:        'San Diego Zoo',
                street1:        :stripeShippingAddressLine1,
                city:           :stripeShippingAddressCity,
                state:          :stripeShippingAddressState,
                zip:            :stripeShippingAddressZip,
                country:        :stripeShippingAddressCountry,
                phone:          '+1 555 341 9393',
                email:          current_user.email },
              parcel:         {
                length:        5,
                width:         2,
                height:        5,
                distance_unit: :in,
                weight:        2,
                mass_unit:     :lb }
}
  end
end

  def receipt
    # I want a 404 if we can't find_by
    @order = Order.find_by! id: params[:id], user_id: current_or_guest_user.id
  end
end
