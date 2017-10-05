class UserNotifierMailer < ApplicationMailer

  def send_sign_up_email(user)
    @user = user
    mail(to: @user.email_id, subject: 'Welcome to Car Rental App.')
  end

  def send_car_availability_email(email_id)
    mail(to: email_id, subject: 'Your requested car is available.')
  end

  def send_car_return_failure_email(email_id)
    mail(to: email_id, subject: 'You did not return car on time.')
  end

end
