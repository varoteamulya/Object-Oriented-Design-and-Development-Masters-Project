class Car < ApplicationRecord

  validates :License, :presence => true , uniqueness:true
  validates :Manufacturer, :presence => true
  validates :Hourly, :presence => true
  validates :Style, :presence => true, inclusion: {in: %w(Sedan Coupe SUV), message: "%{value} is not a valid style"}
  validates :Location, :presence => true
  validates :Availability, :presence => true, inclusion: {in: %w(Checked_Out Available Booked), message: "%{value} is not a valid availability type"}

  def self.search(search)

    where("License LIKE ? OR Manufacturer LIKE ? OR Model LIKE ? OR Hourly LIKE ? OR Style LIKE ? OR Location LIKE ? OR Availability LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%" )

  end


end
