class ApplicationController < ActionController::Base

  protect_from_forgery :with => :exception

  # authenticate if the user is admin
  def authenticate_admin_user!
    authenticate_user!
    #unless user_signed_in? && current_user.is_admin?
    unless current_user.is_admin?
       flash[:alert] = "This area is restricted to administrators only."
       redirect_to root_path
    end
  end

  # get the current user
  def current_admin_user
    return nil if user_signed_in? && !current_user.is_admin?
    current_user
  end

  # redirect to the admin dashboard if user is admin
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && current_user.is_admin?
      admin_dashboard_path
    else
      root_path
    end
  end

  # redirect to root if the user cannot access the page
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

end
