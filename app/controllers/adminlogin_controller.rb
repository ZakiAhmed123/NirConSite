class AdminloginController < ApplicationController

  protect_from_forgery with: :exception

  before_action do
    @admin = Admin.find_by id: session[:admin_id]
  end

  def admin
  end
  
  def create_admin
    Admin.new params.require(:admin).permit(:email, :password)
  end

end
