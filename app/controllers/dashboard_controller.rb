class DashboardController < ApplicationController

  before_action :set_user

  # /dashboard
  def index

  end

  def suggestion
    @suggestion = suggestion.new(suggestion_params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = session[:current_user]
    end

end