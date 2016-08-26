require 'csv'
class ProductsController < ApplicationController

  def embeds
    @products= fetch_products
    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id

  end

  def embed_view
    @products = fetch_products
    @product = @products.find {|a| a.id == params[:id]}
    @order = Order.find_by status: 'cart', user_id:current_or_guest_user.id

  end


  def pdf
    @products = fetch_products
    @product = @products.find {|a| a.id == params[:id]}
  end


end
