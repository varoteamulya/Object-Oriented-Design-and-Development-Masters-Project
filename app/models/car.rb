class Car < ApplicationRecord
  has_many :cars

  self.primary_key = 'license'

  validates :license, :presence => true , uniqueness:true
  validates :manufacturer, :presence => true
  validates :hourly, :presence => true
  validates :style, :presence => true, inclusion: {in: %w(Sedan Coupe SUV), message: "%{value} is not a valid style"}
  validates :location, :presence => true
  validates :availability, :presence => true, inclusion: {in: %w(Checked_Out Available Booked), message: "%{value} is not a valid availability type"}
  validates_with CarsValidator

  def self.search(search)

    where("license LIKE ? OR manufacturer LIKE ? OR model LIKE ? OR hourly LIKE ? OR style LIKE ? OR location LIKE ? OR availability LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%" )

  end


end
