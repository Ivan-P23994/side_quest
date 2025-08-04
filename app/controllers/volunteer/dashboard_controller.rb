class Volunteer::DashboardController < ApplicationController
  def index
    @quests = Quest
      .left_outer_joins(:applications)
      .where("applications.applicant_id IS NULL OR applications.applicant_id != ?", current_user.id)
      .select("quests.*, RANDOM() as rand")
      .order("rand")
      .limit(10)
  end

  def filter_quests
    @quests = quest_filter
  end

  private

  def quest_filter
    quests = Quest.joins(:mission)
    quests = quests.where("missions.title ILIKE ?", "%#{params[:mission_title]}%") if params[:mission_title].present?
    quests = quests.where("quests.title ILIKE ?", "%#{params[:quest_title]}%") if params[:quest_title].present?
    quests
  end
end
