class UsersController < ApplicationController
  def new
  @user=User.new
  end

  def create
  @user = User.new params.require(:user).permit( :name,:email,:password,:address, :password_confirmation)
  if @user.save
   session[:user_id] = @user.id
  redirect_to root_path
  else
   flash.now[:alert] = "Email or Password is Missing"
  render:new
  end
  end

  def settings
  end

  def order_status
  end
end
