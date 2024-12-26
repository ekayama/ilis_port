class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :set_layout


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
  end
  
  def set_layout 
    if user_signed_in? && current_user.admin? 
      "admin" 
    elsif user_signed_in? 
      "user" 
    else 
      "application" 
    end
  end

end
