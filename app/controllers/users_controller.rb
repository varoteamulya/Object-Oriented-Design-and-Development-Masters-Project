class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    check_user
    if @user['u_type'] == 1
      @users = User.all
    elsif @user['u_type'] == 2
      @users = User.where.not(u_type: [1])
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show

  end


  def edit_user
    @user = User.find(params[:email_id])
    @user_edit = UserEdit.new(:email_id => @user['email_id'], :name => @user['name'], :password => @user['password'])
    render action: 'edit'
  end

  def view_user
    @user = User.find(params[:email_id])
    session[:user_context] = User.find(params[:email_id])
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

    render action: 'show'
  end

  def delete_user
    @user = User.find(params[:email_id])
    @user.destroy

    redirect_to dashboard_path
  end

  # GET /users/new
  def new
    check_user
    @sign_up = SignUp.new
    @action = params['action']
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    puts 'here'
    puts params

    # @user = User.new(user_params)
    #
    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to dashboard_path, notice: 'User was successfully created.' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to dashboard_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def check_user
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email_id, :name, :password, :u_type)
    end
end
