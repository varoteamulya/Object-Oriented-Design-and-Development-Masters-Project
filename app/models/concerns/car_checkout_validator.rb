class CarCheckoutValidator < ActiveModel::Validator
  def validate(car_checkout)
    @car_checkout = car_checkout

    if @car_checkout.time_from
      validateTimeFrom(@car_checkout.time_from)
    end

    if @car_checkout.time_to
      validateTimeTo(@car_checkout.time_from)
    end


  end

  def validateTimeFrom(time_from)
    # should not be in past
    puts time_from

    # should not be more than time to

    # should not be more than 7 days from now
  end

  def validateTimeTo(time_to)
    # should not be in past
    puts time_to

    # should not be more than 7 days from now
  end

end