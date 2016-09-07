class AdminsessionsController < ApplicationController

  def new
  end

  def create
    email = params[:email]
    password = params[:password]
    admin = Admin.find_by email: email
    if admin && admin.authenticate(password)
      session[:admin_id] = admin.id
      redirect_to _path(id: admin.id)
    else
      render :new
  end
  end

  def delete
  session[:admin_id] = nil
    redirect_to root_path
 end

end
