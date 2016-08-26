class ReceiptMailer < ApplicationMailer
  default from: 'zakinircon@gmail.com'
  helper_method :current_or_guest_user

  def order_confirmation(user, order)
    @user= user
    @order = order
    mail(to: user.email, subject: 'Order has been received')
  end
end
