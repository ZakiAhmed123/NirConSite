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
    pdf_filename = File.join(Rails.root, '/assets/sample.pdf')
    send_file(pdf_filename, :filename => 'sample.pdf', :type => "application/pdf")
  end

  def chairs
  end

  def beams
  end

end
