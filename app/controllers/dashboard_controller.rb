class DashboardController < ApplicationController

  before_action :set_user

  # /dashboard
  def index
    set_user
    if @user['u_type'] == 3
      @cars = Car.joins('INNER JOIN car_checkouts ON car_checkouts.license = cars.license where car_checkouts.checkout_by = \''+@user['email_id']+'\' and car_checkouts.status=\'booked\'').select("cars.*, car_checkouts.*")
      @reservations = {}
      @cars.each do |car|
        if car.availability == 'Booked'
          unless @reservations['reservedCars']
            @reservations['reservedCars'] = Array.new
          end
          @reservations['reservedCars'].push(car)
        end
      end
      carsHistory = Car.joins('INNER JOIN car_checkouts ON car_checkouts.license = cars.license where car_checkouts.checkout_by = \''+@user['email_id']+'\' and car_checkouts.status=\'checked out\'').select("cars.*, car_checkouts.*")
      carsHistory.each do |car|
        unless @reservations['checkedOutCars']
          @reservations['checkedOutCars'] = Array.new
        end
        @reservations['checkedOutCars'].push(car)
      end

      carsHistory = Car.joins('INNER JOIN car_checkouts ON car_checkouts.license = cars.license where car_checkouts.checkout_by = \''+@user['email_id']+'\' and car_checkouts.status=\'returned\'').select("cars.*, car_checkouts.*")

      carsHistory.each do |car|
        unless @reservations['checkedOutHistory']
          @reservations['checkedOutHistory'] = Array.new
        end
        @reservations['checkedOutHistory'].push(car)
      end

      if AvailabilityRequest.exists?(email: @user['email_id'])
        availability_requests = AvailabilityRequest.where(email: @user['email_id'])
          availability_requests.find_each do |availability_request|
          unless @reservations['requestedCars']
            @reservations['requestedCars'] = Array.new
          end
          car = Car.find(availability_request.license)
          @reservations['requestedCars'].push(car)
        end
      end

    end
  end

  def logout
    puts 'here in logout'
    session.clear

    redirect_to home_path
  end

  def edit_profile
    puts 'in edit', @user
    @user_edit = UserEdit.new(:email_id => @user['email_id'], :name => @user['name'], :password => @user['password'])
  end

  def do_edit_profile
    set_user
    edited_user = filter_edit_user_fields
    @user = User.find(@user['email_id'])
    @user.update_column(:name, edited_user['name'])
    @user.update_column(:password, edited_user['password'])
    @user.save

    redirect_to dashboard_path
  end

  def suggested_car
     @suggestion = Suggestion.all;
  end


  def suggest_car
    @suggestion = Suggestion.all;
  end

  def new_suggest_car
    suggestion = filter_suggested_car_fields
    suggestion[:suggested_by] = @user['email_id']
    @suggestion = Suggestion.new(suggestion)
    if @suggestion.save
      redirect_to dashboard_path
    end

  end

  def make_reservation
    @users = User.where(u_type: 3)
  end

  def user_make_reservation
    puts params
    session[:user_context] = User.find(params[:email_id])
    redirect_to cars_path
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

    def filter_edit_user_fields
      params.require(:user_edit).permit(:email_id, :name)
    end

    def car_params
      params.require(:car).permit(:license, :Plate, :manufacturer, :model, :hourly, :Rental, :Rate, :style, :location, :availability, :checkout)
    end
end