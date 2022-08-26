class ApplicationController < ActionController::Base
  # Only authenticate users can access to controllers (unless skip_before_action)
  before_action :authenticate_user!

  # Add more parameters to a user creation
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pundit: white-list approach.
  include Pundit
  after_action :verify_authorized, except: %i[index available], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: %i[index available], unless: :skip_pundit?

  # Add flash alerts
  add_flash_types :notice, :alert, :success

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à réaliser cette action"
    redirect_to(root_path)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || available_paintings_path
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(^messages$)|(^queries$)|(^errors$)|(^sitemap$)/
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end
end
