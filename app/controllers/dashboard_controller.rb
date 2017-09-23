class DashboardController < ApplicationController

  before_action :set_user

  # /dashboard
  def index
    @cars = Car.all

    puts @user
  end

  def book
    puts "in book"
    puts params
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(session[:current_user_id])
    end

end