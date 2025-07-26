class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

def create
  if User.exists?(email_address: params[:user][:email_address])
    redirect_to new_registration_path, alert: "Email address already registered."
    return
  end

  @user = User.new(user_params)
  if @user.save(context: :registration)
    start_new_session_for @user
    redirect_to root_path, notice: "Successfully signed up!"
  else
    render :new, status: :unprocessable_entity
  end
end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :source, :user_type)
  end
end
