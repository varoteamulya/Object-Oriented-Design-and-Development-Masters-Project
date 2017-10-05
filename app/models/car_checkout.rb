class CarCheckout < ApplicationRecord
  has_many :cars

  validates_presence_of :license, :checkout_by
  validates_with CarCheckoutValidator
end
