class DashboardController < ApplicationController

  before_action :set_user

  # /dashboard
  def index

  end

  def logout
    puts 'here in logout'
    session.clear

    redirect_to home_path
  end

  def suggest_car

  end

  def new_suggest_car
    puts filter_suggested_car_fields
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = session[:current_user]
      unless @user
        redirect_to home_path
      end
    end

    def filter_suggested_car_fields
      params.permit(:Manufacturer, :Model)
    end
end