require 'rails_helper'

RSpec.describe Car, :type => :model do
  subject { described_class.new }


  it "is not valid without a license" do
    subject.id = "Anything"
    expect(subject).to_not be_valid
  end

  it "is not valid without a manufacturer" do
    subject.id = "Anything"
    subject.license = "Car License"
    expect(subject).to_not be_valid
  end

  it "is not valid without a hourly" do
    subject.id = "Anything"
    subject.license = "Car License"
    subject.manufacturer = "Anything"
    expect(subject).to_not be_valid
  end

  it "is not valid without a style" do
    subject.id = "Anything"
    subject.license = "Car License"
    subject.manufacturer = "Anything"
    subject.hourly = "Anything"
    expect(subject).to_not be_valid
  end

  it "is not valid without a location" do
    subject.id = "Anything"
    subject.license = "Car License"
    subject.manufacturer = "Anything"
    subject.hourly = "Anything"
    subject.style = "Anything"
    expect(subject).to_not be_valid
  end

  it "is not valid without a availability" do
    subject.id = "Anything"
    subject.license = "Car License"
    subject.manufacturer = "Anything"
    subject.hourly = "Anything"
    subject.style = "Anything"
    subject.location = "Anything"
    expect(subject).to_not be_valid
  end



end