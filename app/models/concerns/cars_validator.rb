class CarsValidator < ActiveModel::Validator
  def validate(car)
    puts "Validating car"
    puts
  end
end