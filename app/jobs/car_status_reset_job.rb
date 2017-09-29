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
      if AvailabilityRequest.exists?(license: car.license)
        availability_requests = AvailabilityRequest.where(license: car.license)
        availability_requests.find_each do |availability_request|
          UserNotifierMailer.send_car_availability_email(availability_request.email).deliver_now
        end
      end
    end
  end

end
