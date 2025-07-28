class MissionsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)

    respond_to do |format|
      if @mission.save
        format.turbo_stream
      else
        render turbo_stream: turbo_stream.prepend(
        "flash-messages",
        partial: "shared/alert",
        locals: { message: "Mission creation failed" }
      )
      end
    end
  end

def edit
  @mission = Mission.find(params[:id])
end



def update
  @mission = Mission.find(params[:id])

  if @mission.update(mission_params)
    respond_to do |format|
      format.turbo_stream
    end
  else
    render turbo_stream: turbo_stream.prepend(
        "flash-messages",
        partial: "shared/alert",
        locals: { message: "Mission edit failed" }
      )
  end
end

  def destroy
    @mission = Mission.find(params[:id])

    respond_to do |format|
      if @mission.destroy
        format.turbo_stream
      else
      render turbo_stream: turbo_stream.prepend(
        "flash-messages",
        partial: "shared/alert",
        locals: { message: "Mission deactivation failed" }
      )
      end
    end
  end
end

private
def mission_params
  params.require(:mission).permit(:title, :body, :owner_id)
end
