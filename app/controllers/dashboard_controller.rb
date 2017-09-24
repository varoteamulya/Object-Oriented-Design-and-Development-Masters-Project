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
    suggestion = filter_suggested_car_fields
    suggestion[:suggested_by] = @user['email_id']
    @suggestion = Suggestion.new(suggestion)
    if @suggestion.save
      redirect_to dashboard_path
    end

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
      params.permit(:manufacturer, :model)
    end
end