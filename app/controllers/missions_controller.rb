class MissionsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

def edit
  @mission = Mission.find(params[:id])

  respond_to do |format|
    format.turbo_stream # renders edit.turbo_stream.erb by default
    format.html { render partial: "missions/form_modal", locals: { mission: @mission } }
  end
end



def update
  @mission = Mission.find(params[:id])
  if @mission.update(mission_params)
    redirect_to missions_path, notice: "Mission updated successfully."
  else
    render partial: "missions/form_modal", locals: { mission: @mission }
  end
end

  def destroy
  end
end
