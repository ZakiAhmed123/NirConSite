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
    @filterrific = initialize_filterrific(
      Product,
      params[:filterrific]
    ) or return
    @products = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def beams_view
    @product= Product.find_by id: params[:id]
  end
end
