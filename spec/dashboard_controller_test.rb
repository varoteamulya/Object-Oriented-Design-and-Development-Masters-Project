require 'rails_helper'
require 'spec_helper'

describe DashboardController do
  let(:dashboard_controller){DashboardController.new}
  describe '#index' do
    it 'displays the checkout history' do
        sub = dashborad_controller
       result = sub.index
       expect(result).to eq ''
    end
  end

  describe '#suggested_car' do
    it 'gives suggested car' do
      @car.stub(:all)
      @suggestion.stub(:all)

    end
  end

  describe '#suggest_car' do
    it 'suggest a car' do
      @suggestion.stub(:all)
    end
  end

  describe '#new_suggest_car' do
    it  'it gives new suggested car' do
      suggestion = Suggestion.new(
          id:1,
          manufacturer:'abc',
          model:'xyz',
          created_by:DateTime.now,
          updated_by:DateTime.now,
          suggested_by:'abc'
      )
      @suggestion.stub(:suggestion)
      dashboard_controller.new_suggest_car
    end
  end

  describe '#make_reservation' do
    it 'makes reservation' do
      User.should_receive(:where).with(:u_type => 3)
      dashboard_controller.make_reservation
    end
  end

  describe '#user_make_reservation' do
    it 'user makes reservation' do
      sub = dashboard_controller
      result = sub.user_make_reservation
      expect(result).to be 'abc'
    end
  end

  describe '#do_edit_profile' do
    it 'do edits the profile' do
      edited_user = dashboard_controller.send(:filter_edit_user_fields)
      expect_any_instance_of(User).to receive(:edited_user).
          with({email_id: 'abc@gmail.com', name: 'abc'}.with_indifferent_access)
    end
  end

end


