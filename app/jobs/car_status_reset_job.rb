class CarStatusResetJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts 'executing job to check and update car status'
    car = args[0]
    car_checkout = args[1]
    if car.availability == 'Booked'
      car.availability = 'Available'
      car.save

      car_checkout.destroy

      #send mail to users who had requested for email
      #change this
      user = User.find("nielarshi@gmail.com")
      UserNotifierMailer.send_car_availability_email(user).deliver_now
    end
  end

end
