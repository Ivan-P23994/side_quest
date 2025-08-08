class QuestsController < ApplicationController
  before_action :set_quest, only: [ :show, :edit, :update, :destroy, :show_applications ]

  def index
    if params[:mission_id]
      @mission = set_mission
      @quests = Quest.where(mission_id: params[:mission_id])
    else
      @quests = Quest.all
    end
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)

    respond_to do |format|
      if @quest.save
        format.turbo_stream
      else
        render turbo_stream: turbo_stream.prepend(
          "flash-messages",
          partial: "shared/alert",
          locals: { message: "Quest creation failed" }
        )
      end # <--- ADDED: closes the if @quest.save block
    end   # <--- ADDED: closes the respond_to block
  end     # <--- ADDED: closes the create method

  def show
    # @quest is set by before_action :set_quest
  end

  def my_quests
    @quests = current_user.quests
  end

  def edit
    # @quest is set by before_action :set_quest
    @mission = @quest.mission if @quest.mission
  end

  def update
    if @quest.update(quest_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render turbo_stream: turbo_stream.prepend(
        "flash-messages",
        partial: "shared/alert",
        locals: { message: "Quest edit failed" }
      )
    end
  end

  def destroy
    if @quest.destroy
      respond_to do |format|
        format.turbo_stream
      end
    else
      render turbo_stream: turbo_stream.prepend(
        "flash-messages",
        partial: "shared/alert",
        locals: { message: "Quest deactivation failed" }
      )
    end
  end

  def apply_for_quest
    @quest = Quest.find(params[:id])
    if !current_user.can_apply_for?(@quest)
      @quest.applications.create(applicant: current_user, status: "pending", approver: @quest.mission.owner)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render turbo_stream: turbo_stream.prepend(
        "flash-messages",
        partial: "shared/alert",
        locals: { message: "You can not apply to this quest", flash_type: :error }
      )
    end
  end

  def show_applications
    @quest = Quest.find(params[:id])
    @applications = not_processed_applications
    @processed_applications = processed_applications
  end

  def approve_application
    @application = Application.find(params[:id])
    if @application.approver == current_user && @application.status == "pending"
      @application.update(status: "approved")
      register_user_quest
      respond_to do |format|
        format.turbo_stream
      end
    else
      render turbo_stream: turbo_stream.prepend(
        "flash-messages",
        partial: "shared/alert",
        locals: { message: "You can not approve this application" }
      )
    end
  end

  def reject_application
    @application = Application.find(params[:id])
    if @application.approver == current_user && @application.status == "pending"
      @application.update(status: "rejected")
      respond_to do |format|
        format.turbo_stream { render "approve_application" }
      end
    else
      render turbo_stream: turbo_stream.prepend(
        "flash-messages",
        partial: "shared/alert",
        locals: { message: "You can not reject this application" }
      )
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :mission_id)
  end

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def set_mission
    Mission.find(params[:mission_id]) if params[:mission_id]
  end

  def processed_applications
    Application.where(approver: current_user, quest: @quest).where.not(status: "pending")
  end

  def not_processed_applications
    Application.where(approver: current_user, quest: @quest).where(status: "pending")
  end

  def register_user_quest
    UserQuest.create!(
      user: current_user,
      quest: @quest
    )
  end
end
