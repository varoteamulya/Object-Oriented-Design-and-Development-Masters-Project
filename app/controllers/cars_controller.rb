class CarsController < ApplicationController
  before_action :check_authorization

  # GET /cars
  # GET /cars.json

  def index
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

  def new_suggested
    suggestion = filter_suggested_car_fields
    @car = Car.new
    @car['manufacturer'] = suggestion[:manufacturer]
    @car['model'] = suggestion[:model]
  end
  # GET /cars/1/edit
  def edit

  end

  def cancel_reservation
    session[:user_context] = nil
    redirect_to dashboard_path
  end

  def cancel_booking
    check_user_context

    puts 'here in cancel booking', params
    @car = Car.find(params[:car])
    @car.update_column(:availability, "Available")
    @car.save

    if AvailabilityRequest.exists?(license: @car.license)
      availability_requests = AvailabilityRequest.where(license: @car.license)
      availability_requests.find_each do |availability_request|
        UserNotifierMailer.send_car_availability_email(availability_request.email).deliver_now
        availability_request.destroy
      end
    end

    @checkout = CarCheckout.where(:license => @car.license, :checkout_by => @user_context['email_id'], :status => 'booked').take
    @checkout.update_column(:status, 'canceled')
    @checkout.save

    redirect_to dashboard_path
  end

  # GET /cars/1
  # GET /cars/1.json
  def book_car
    check_user_context
    @car = Car.find(params[:car])

    unless check_already_booked

      @checkout = CarCheckout.new(
          :license => @car['license'],
          :checkout_by => @user_context['email_id'],
          :checkout_at => DateTime.now,
          :status => 'booked',
          :time_to => DateTime.now + 30.minutes,
          :time_from => DateTime.now
      )

      @checkout.save

      @car.update_column(:availability, "Booked")
      @car.save

      #start cron job
      CarStatusResetJob.set(wait: 30.minutes).perform_later(@car, @checkout)

      redirect_to dashboard_path

    else
      redirect_to cars_path, notice: 'Sorry! You have already booked/checked out a car.'
    end

  end

  def check_already_booked
    if CarCheckout.exists?(checkout_by: @user_context['email_id'], status: ["checked out", "booked"])
      return true;
    end
    return false;
  end

  def checkout
    check_user_context
    @car = Car.find(params[:car])

    unless @checkout
      @checkout = CarCheckout.new(:license => @car['license'], :checkout_by => @user_context['email_id'])
    end
    puts @car

    if params[:motive]
      puts 'it is for instant checkout'
      @checkout = CarCheckout.where(:license => @car.license, :checkout_by => @user_context['email_id'], :status => 'booked').take
      @checkout.update_column(:status, 'checked out')
      @checkout.save

      @car.update_column(:availability, "Checked_Out")
      @car.save
    end

  end

  def do_checkout

    if params[:reserve]
      puts 'reserving car'
      car_checking_out = params[:car_checkout]
      puts car_checking_out[:time_from]

      check_user_context
      @car = Car.find(car_checking_out[:license])

      @checkout = CarCheckout.new(:license => @car['license'], :checkout_by => @user_context['email_id'])
      if car_checking_out[:time_from] == ""
        @checkout.errors.add(:time_from, 'cannot be empty')
        render action: 'checkout'
      else
        car_checking_out = car_checkout

        puts car_checking_out

        checkout_at = DateTime.parse(car_checking_out[:time_from]).getutc
        time_to = checkout_at + car_checking_out['duration'].to_i.hours
        @checkout = CarCheckout.new(
            :time_from => checkout_at,
            :time_to => time_to,
            :license => car_checking_out['license'],
            :checkout_by => car_checking_out['checkout_by'],
            :checkout_at => checkout_at,
            :status => 'booked',
            :duration => car_checking_out['duration'].to_i
        )

        @car = Car.find(@checkout.license)
        @checkout.save

        @car.update_column(:availability, "Booked")
        @car.save

        # run a background job to fire email
        #CarStatusResetJob.set(wait_until: time_to).perform_later(@car, @checkout)

        redirect_to dashboard_path
      end

    else

      car_checking_out = car_checkout

        puts car_checking_out

        checkout_at = DateTime.now
        time_to = checkout_at + car_checking_out['duration'].to_i.hours
        @checkout = CarCheckout.new(
                                   :time_from => checkout_at,
                                   :time_to => time_to,
                                   :license => car_checking_out['license'],
                                   :checkout_by => @user_context['email_id'],
                                   :checkout_at => checkout_at,
                                   :status => 'checked out',
                                   :duration => car_checking_out['duration'].to_i
                    )

        set_user
        @car = Car.find(@checkout.license)

        if @checkout.valid?
          puts 'valid'

          if CarCheckout.exists?(:license => @car.license, :checkout_by => @user_context['email_id'], :status => 'booked')

            @checkout = CarCheckout.where(:license => @car.license, :checkout_by => @user_context['email_id'], :status => 'booked').take
            @checkout.update_column(:status, 'checked out')
            @checkout.update_column(:time_from, checkout_at)
            @checkout.update_column(:time_to, time_to)
            @checkout.update_column(:checkout_at, checkout_at)
            @checkout.update_column(:checkout_at, car_checking_out['duration'].to_i)

          end

          @checkout.save

          @car.update_column(:availability, "Checked_Out")
          @car.save

          # run a background job to fire email
          CarStatusResetJob.set(wait_until: time_to).perform_later(@car, @checkout)

          redirect_to dashboard_path
        else
          puts 'invalid'
          render action: 'checkout'
        end

    end


  end

  def return_car
    check_user_context

    puts 'here in return', params
    @car = Car.find(params[:car])
    @car.update_column(:availability, "Available")
    @car.save

    if AvailabilityRequest.exists?(license: @car.license)
      availability_requests = AvailabilityRequest.where(license: @car.license)
      availability_requests.find_each do |availability_request|
        UserNotifierMailer.send_car_availability_email(availability_request.email).deliver_now
        availability_request.destroy
      end
    end

    @checkout = CarCheckout.where(:license => @car.license, :checkout_by => @user_context['email_id'], :status => 'checked out').take
    @checkout.update_column(:status, 'returned')
    @checkout.save

    redirect_to dashboard_path
  end

  def register_for_email
    availability_requests = AvailabilityRequest.new(
           :email => @user_context['email_id'],
           :license => params[:car]
    )

    availability_requests.save

    redirect_to dashboard_path

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
       check_user_context
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

    def check_user_context
      if session[:user_context]
        @user_context = session[:user_context]
      else
        if @user['u_type'] == 3
          @user_context = @user
        end
      end
    end


  def filter_suggested_car_fields
    params.require(:values)
  end



  def car_checkout
    params.require(:car_checkout).permit(:time_from, :duration, :checkout_by, :license)
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      puts params
      params.require(:car).permit(:license, :Plate, :manufacturer, :model, :hourly, :Rental, :Rate, :style, :location, :availability, :checkout)
    end

end
