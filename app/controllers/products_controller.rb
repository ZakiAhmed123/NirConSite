require 'csv'
class ProductsController < ApplicationController

  def embeds
    @products= fetch_products
    @stabilizers= fetch_stabilizers
  end

  def embed_view
    @products = fetch_products
    @product = @products.find {|a| a.id == params[:id]}
    @orderitem=OrderItem.new(orderitem_params)
  end


  def pdf
    @products = fetch_products
    @product = @products.find {|a| a.id == params[:id]}
  end

  def stabilizer
    @stabilizers= fetch_stabilizers
    @stabilizer = @stabilizers.find {|a| a.id == params[:id]}
    @orderitem=OrderItem.new
  end

  def stabilizer_pdf
    @stabilizers= fetch_stabilizers
    @stabilizer = @stabilizers.find {|a| a.id == params[:id]}
  end

  private
  def orderitem_params
    params.permit(:quantity)
  end

end
