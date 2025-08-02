class QuestsController < ApplicationController
  before_action :set_mission, only: [ :new, :create, :index ]
  before_action :set_quest, only: [ :show, :edit, :update, :destroy ]

  def index
    if params[:mission_id]
      @mission = set_mission
      @quests = Quest.where(mission_id: params[:mission_id])
    else
      @quests = Quest.all
    end
  end

  def show
    # @quest is set by before_action :set_quest
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
      end
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
end
