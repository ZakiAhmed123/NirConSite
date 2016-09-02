class ReceiptMailer < ApplicationMailer
  default from: 'info.nircon@gmail.com'
  helper_method :current_or_guest_user

  def order_confirmation(user, order)
    @user= user
    @order = order
    mail(to: [order.email,'nirconrd@gmail.com'], subject: 'Order has been received')
  end
end
