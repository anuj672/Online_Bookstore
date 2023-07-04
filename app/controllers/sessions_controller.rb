class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def new
  end

  def create
    admin = Admin.find_by_username(params[:username])
    user = User.find_by_username(params[:username])

    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to root_url, notice: "Logged in as admin!"
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Username or password is invalid"
      render "new", status: :unprocessable_entity
      #, status::unprocessable_entity
    end
  end

  def destroy
    (session[:user_id] = nil && session[:cart] = nil) || session[:admin_id] = nil

    redirect_to root_url, notice: "Logged out!"
  end
end
