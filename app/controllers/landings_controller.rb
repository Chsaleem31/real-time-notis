class LandingsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def send_alert
    @msg = params[:msg]
    Twilio::SendSmsService.new(current_user.phone_number, @msg).send_msg
  end
end
