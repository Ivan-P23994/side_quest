class Organization::DashboardController < ApplicationController
  before_action :set_missions
  def index
  end

  private

  def set_missions
    @missions = Mission.where(owner_id: Current.user.id)
  end
end
