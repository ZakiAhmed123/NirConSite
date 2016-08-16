class ReceiptMailer < ApplicationMailer
  default from: 'zakinircon@gmail.com'
  helper_method :current_or_guest_user

  def order_confirmation(user, order, order_items)
    current_or_guest_user = user
    @order = order
    @order_items = order_items
    mail(to: user.email, subject: 'Order has been received')
  end
end
