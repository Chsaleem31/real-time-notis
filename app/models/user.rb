class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_format_of :phone_number, with: /\A\+\d{2}\d{9,15}\z/, message: "invalid!"

  after_create :send_welcome_sms

  private

  def send_welcome_sms
    response = Twilio::SendSmsService.new(phone_number, SIGN_UP_MSG).send_msg

    unless response.fetch(:status)
      errors.add(:base, response.fetch(:msg))
      raise ActiveRecord::Rollback
    end
  end
end
