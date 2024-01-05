class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :valid_phone_number_format

  def valid_phone_number_format
    return errors.add(:phone_number, "invalid") unless phone_number =~ /\A\+\d{2}\d{9,15}\z/

    response = Twilio::SendSmsService.new(phone_number, SIGN_UP_MSG).send_msg

    return if response.fetch(:status)

    errors.add(:phone_number, response.fetch(:msg))
  end
end
