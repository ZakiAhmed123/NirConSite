class CheckoutController < Wicked::WizardController
  include Wicked::Wizard
  steps :shipping

  before_action do
        if current_or_guest_user.nil?
          redirect_to sign_in_path
        end
      end

  def update
    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id
    @order.update_attributes(order_params)
    render_wizard @order
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

    def redirect_to_finish_wizard
      redirect_to payment_payment, notice: "Thank You for Your Information"
    end
end
