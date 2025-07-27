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
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("mission-form", partial: "form"),
                 status: :unprocessable_entity
        end
      end
    end
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

private
def mission_params
  params.require(:mission).permit(:title, :body, :owner_id)
  # params.merge(owner_id: Current.user.id) if Current.user
end
