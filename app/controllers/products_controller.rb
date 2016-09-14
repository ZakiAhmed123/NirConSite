class ProductsController < ApplicationController

  def embeds
    @products= Product.all

  end

  def embed_view
    @product= Product.find_by id: params[:id]

  end


  def pdf
    @products = fetch_products
    @product = @products.find {|a| a.id == params[:id]}
    pdf_filename = File.join(Rails.root, '/assets/sample.pdf')
    send_file(pdf_filename, :filename => 'sample.pdf', :type => "application/pdf")
  end

  def chairs
    @products= Product.all
  end

  def beams
  end

end
