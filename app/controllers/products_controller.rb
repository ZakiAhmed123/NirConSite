class ProductsController < ApplicationController

  def embeds
    @products= Product.all

  end

  def embed_view
    @product= Product.find_by id: params[:id]
  end



  def chairs
    @products= Product.all

  end

  def chairs_view
    @product= Product.find_by id: params[:id]
  end

  def beams
    @products=Product.all
  end

  def beams_view
    @product= Product.find_by id: params[:id]
  end

  def studs_view
    @product= Product.find_by id: params[:id]
  end
end
