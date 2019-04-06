class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options
    { lang: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def after_sign_in_path_for(resource)
    flash[:notice] = "Привет, #{resource.name}!"
    resource.admin? ? admin_tests_path : super
  end

  def set_locale
      I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end
end
