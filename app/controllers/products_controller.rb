require 'csv'
class ProductsController < ApplicationController

  def embeds
    @products= fetch_products

  end

  def embed_view
    @products = fetch_products
    @product = @products.find {|a| a.id == params[:id]}

  end


  def pdf
    @products = fetch_products
    @product = @products.find {|a| a.id == params[:id]}
  end

  def chairs
  end

  def beams
  end

end
