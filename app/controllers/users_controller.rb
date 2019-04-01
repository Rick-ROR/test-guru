class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  
  def new
    if logged_in?
      redirect_to tests_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if email_unique?(@user.email) && @user.save
      session[:user_id] = @user.id
      redirect_to tests_path
    else
      render :new
    end
  end

  private

  def email_unique?(email)
    result = User.where(email: email).blank?
    flash.now[:alert] = '%username% c таким e-mail уже существует!' unless result
    result
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
