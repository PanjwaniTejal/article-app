class SendConfirmationInstructionJob < ApplicationJob
  queue_as :default

  def perform(token)
    UserMailer.confirmation_notify(token).deliver_now
  end
end
