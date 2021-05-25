class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  before_create :generate_confirmation_token
  after_create :send_confirmation_email

  has_many :articles
  
  def valid_confimation_token?
    # Token valide for 2 days
    (self.confirmation_sent_at.to_time + 2.days) > Time.now
  end

  def token_confirmed!
    self.confirmation_token = nil
    self.confirmed_at = Time.now
    self.save
  end

  def confirm?
    confirmed_at?
  end

  private
  def generate_confirmation_token
    self.confirmation_token = SecureRandom.hex(10)
    self.confirmation_sent_at = Time.now
  end

  def send_confirmation_email
    SendConfirmationInstructionJob.perform_now(self.confirmation_token)
  end
end
