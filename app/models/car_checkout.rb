class CarCheckout < ApplicationRecord
  has_many :cars

  validates_with CarCheckoutValidator
end
