class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permited_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
