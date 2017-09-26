class CarCheckoutValidator < ActiveModel::Validator
  def validate(car_checkout)
    puts 'validating'
  end
end