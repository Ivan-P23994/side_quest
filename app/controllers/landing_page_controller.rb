class LandingPageController < ApplicationController
  allow_unauthenticated_access

  def landing
    if authenticated?
      redirect_to current_user.dashboard_path
    else
      render :landing
    end
  end

  private

  def user_type
    current_user&.user_type
  end
end
