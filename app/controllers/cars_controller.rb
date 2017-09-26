class CarsController < ApplicationController
  before_action :check_authorization, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json

  def index
    set_user
    puts params[:search]
    if params[:search] &&
        !params[:search].empty?
      @cars = Car.search(params[:search])#.order("created_at DESC")
    else
      @cars = Car.all
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    unless @car
      action = params['id']
      if action == 'return_car'
        return_car
      elsif action == 'book_car'
        book_car
      end
    else
      @checkout = CarCheckout.new(:checkout_by => @user['email_id'] , :license => @car.license)
      puts @checkout
      set_user
      puts @user
    end
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # GET /cars/1
  # GET /cars/1.json
  def book_car
    @car = Car.find(params[:car])
    @car.update_column(:availability, "Booked")
    @car.save

    # @checkout = CarCheckout.new

    #start cron job
    CarStatusResetJob.set(wait: 30.minutes).perform_later(@car)

    redirect_to dashboard_path
  end

  def checkout
    @car = Car.find(params[:car])
    @checkout = CarCheckout.new(:license => @car['license'], :checkout_by => @user['email_id'])
    puts @car

  end

  def do_checkout

    car_checking_out = car_checkout

    @checkout = CarCheckout.new(:license => car_checking_out['license'], :checkout_by => car_checking_out['checkout_by'], :status => 'checked out')

    @car = Car.find(@checkout.license)
    set_user

    @car.update_column(:availability, "Checked_Out")
    @car.save

    @checkout.save

    redirect_to dashboard_path

  end

  def return_car
    puts 'here in return', params
    @car = Car.find(params[:car])
    @car.update_column(:availability, "Available")
    @car.save

    @checkout = CarCheckout.where(:license => @car.license, :checkout_by => @user['email_id'], :status => 'checked out').take
    @checkout.update_column(:status, 'returned')
    @checkout.save

    redirect_to dashboard_path
  end

  def register_for_email
    @car = Car.find(params[:car])

    #add user req to db
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    @car.availability = 'Available'

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def check_authorization
       puts 'checking authorization'
       set_user
       set_car
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_car
      if Car.exists?(params[:id])
        @car = Car.find(params[:id])
      end
    end

    def set_user
      @user = session[:current_user]
      unless @user
        redirect_to home_path
      end
    end

  def car_checkout
    params.require(:car_checkout).permit(:duration, :checkout_by, :license)
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:license, :Plate, :manufacturer, :model, :hourly, :Rental, :Rate, :style, :location, :availability, :checkout)
    end
end
