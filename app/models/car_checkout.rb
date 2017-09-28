class CarCheckout < ApplicationRecord
  has_many :cars

  validates_presence_of :license, :checkout_by, :time_from, :time_to
  validates_with CarCheckoutValidator
end
