class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by email: email

    if user && user.authenticate(password)
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_path
  else
    flash.now.alert = "Invalid Email or Password"
      render :new
  end
end

  def delete
  cookies.delete(:auth_token)
  redirect_to root_path
 end

end
