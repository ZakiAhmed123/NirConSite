class ProductsController < ApplicationController

  def products
  end
  
  def embeds
    @products= Product.where('category=?','embed')
    @stabilizers =Product.where('category=?','stabilizer')
  end

  def embed_view
    @product= Product.find_by id: params[:id]
  end

  def chairs
    @products= Product.where('category=?','chair').order('id DESC')

  end

  def chairs_view
    @product= Product.find_by id: params[:id]
  end

  def studs
    @Studs= Product.where('category=?','Stud')
    @Tracks= Product.where('category=?','Track')

  end

  def tracks_view
    @product= Product.find_by id: params[:id]
  end

  def studs_view
    @product= Product.find_by id: params[:id]
  end

  def stabilizers_view
    @product= Product.find_by id: params[:id]
  end

  def beams
  end
end
