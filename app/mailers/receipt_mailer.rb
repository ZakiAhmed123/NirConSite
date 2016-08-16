class ReceiptMailer < ApplicationMailer
  default from: 'zakinircon@gmail.com'
  helper_method :current_or_guest_user

  def order_confirmation(@user, @order)
    @user= current_or_guest_user
    @order = order
    mail(to: current_or_guest_user.email, subject: 'Order has been received')
  end
end
