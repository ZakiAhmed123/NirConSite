class BssController < ApplicationController
  def panel
    @orders = Order.where('(status= ?) OR (status= ?) OR (status=?) OR (status=?)', 'pending', 'complete', 'canceled', 'shipped')

  end

  def show
  @order = Order.find_by id: params[:id]
  end

  def update
    @order = Order.find_by id: params[:id]
    @order.update_attributes(order_params)
    if @order.save
      redirect_to request.referrer
    end
  end


private
def order_params
  params.require(:order).permit(:status, :address_line1, :address_city, :address_zip, :address_state, :name,:phone_number)
end
end
