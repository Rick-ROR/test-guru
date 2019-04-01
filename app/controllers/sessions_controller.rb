class SessionsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
      redirect_to tests_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:after_login_path] || tests_path
    else
      flash.now[:alert] = 'Авторизуйтесь пожалуйста!'
      render :new
    end
  end

  def drop
    cookies.delete :after_login_path
    session.delete(:user_id)
    @current_user = nil
    redirect_to login_path
  end
end
