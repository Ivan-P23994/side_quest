class Business::DashboardController < ApplicationController
  def index
    @missions = Mission.all
  end

  def filter_missions
    @missions = mission_filter
  end

  private

  def mission_filter
    missions = Mission.joins(owner: :profile)
    missions = missions.where("missions.title ILIKE ?", "%#{params[:mission_title]}%") if params[:mission_title].present?
    missions = missions.where("profiles.username ILIKE ?", "%#{params[:organization_name]}%") if params[:organization_name].present?
    missions
  end
end
