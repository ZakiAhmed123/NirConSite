class BasicsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def contact

  end

  def home
  end

  def policies
  end

  def shipping_info
  end
end
