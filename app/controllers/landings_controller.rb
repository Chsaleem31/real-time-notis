class LandingsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    response = Twilio::SendSmsService.new(current_user.phone_number, params[:msg], current_user.name).send_msg

    if response.fetch(:status)
      flash[:notice] = params[:msg]
    else
      flash[:alert] = response.fetch(:msg)
    end

    redirect_to root_path
  end
end
