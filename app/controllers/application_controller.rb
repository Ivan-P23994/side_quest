class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  # before_action :set_layout

  # def set_layout
  # @layout = user_signed_in? ? "application" : "authentication"
  # end

  def current_user
    Current.user
  end
end
