class ApplicationController < ActionController::Base
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def layout_by_resource
    if devise_controller?
     "devise"
    else
      "application"
    end
  end

  def user_must_not_sign_in
    if user_signed_in?
      if current_user.is_admin?
        redirect_to admin_index_url
      else
        redirect_to user_index_url

      end
    end
  end
end
