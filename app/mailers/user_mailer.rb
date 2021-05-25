class UserMailer < ApplicationMailer

  def confirmation_notify(token)
    @user = User.find_by(confirmation_token: token)
    mail(to: @user.email, subject: 'Confirmation Email Address')
  end
end
