class Twilio::SendSmsService
  attr_reader :message, :contact

  DEFAULT_TWILIO_SENDER = '+16504601142'

  def initialize(contact, message)
    @contact = contact
    @message = message
  end

  def send_msg
    begin
      @client = Twilio::REST::Client.new
      sms = @client.messages.create(
        body: message,
        from:  DEFAULT_TWILIO_SENDER,
        to: contact
      )
      { status: true }
    rescue Twilio::REST::RestError => e
      { status: false, msg: e.code == 21211 ? 'invalid' : "Twilio Error (#{e.message})"}
    end
  end
end
