require 'spec_helper'
require 'rails_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car = cars(:one)
  end


  describe "#index" do
  it "should get index" do
    @car.stub(:all)
  end
end

  describe "#show" do
  it "should show details" do
    @checkout.stub(to_s)
  end
  end

  describe '#new_suggested' do
    it  'it gives new suggested car' do
      @car.stub(:all)
    end
  end

  describe "cancel_reservation" do
    it "cancels the reservation" do
    gets 'cancel_reservation'
    assert_redirected_to dashboard_path
    end
  end

end
