class BssController < ApplicationController
  before_action :authenticate_vendor!
  def panel
    @orders = Order.where('(status=?) OR (status=?) OR (status=?) OR (status=?)', 'pending', 'shipped', 'canceled', 'complete')

  end

  def show
  @order = Order.find_by id: params[:id]
  end

  def update
    @order = Order.find_by id: params[:id]
    @order.update_attributes(order_params)
    if @order.save
      flash[:success] = "Successfully Edited Order"
      redirect_to request.referrer
    end
  end


private
def order_params
  params.require(:order).permit(:status, :address_line1, :address_city, :address_zip, :address_state, :name,:phone_number)
end
end
