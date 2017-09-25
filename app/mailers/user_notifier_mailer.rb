class UserNotifierMailer < ApplicationMailer

  def send_sign_up_email(user)
    @user = user
    mail(to: @user.email_id, subject: 'Welcome to Car Rental App')
  end

end
