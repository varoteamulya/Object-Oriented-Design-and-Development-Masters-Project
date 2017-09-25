class HomeController < ApplicationController
  def home

  end

  # GET /login
  def login
    @login = Login.new
  end

  # POST /login
  def user_login
    @login = Login.new(login_params)

    puts @login

    #validate user
    if @login.valid?
      puts 'valid'
      email_id = @login.email_id
      password = @login.password

      puts email_id, password

      # get user based on email id passed
      @user = User.find(email_id)

      # set user id into session
      session[:current_user] = @user

      # redirect to dashboard
      redirect_to dashboard_path

    else
      puts 'invalid'
      render action: 'login'
    end
  end

  # GET /sign_up
  def sign_up
    @sign_up = SignUp.new
  end

  # POST /sign_up
  def user_sign_up
    #check if its not blank
    @sign_up = SignUp.new(signup_params)

    if @sign_up.valid?
      puts 'valid'

      params_to_pass = user_params

      params_to_pass[:u_type] = 3
      puts params_to_pass

      # create new user
      @user = User.new(params_to_pass)
      @user.save

      # set user id into session
      session[:current_user] = @user

      # UserNotifierMailer.send_sign_up_email(@user).deliver_now

      redirect_to dashboard_path

    else
      puts 'invalid'
      render action: 'sign_up'
    end

    #check if user is already present or not


  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def login_params
    params.require(:login).permit(:email_id, :password)
  end

  def signup_params
    params.require(:sign_up).permit(:email_id, :name, :password, :confirm_password)
  end

  def user_params
    signup_params.permit(:email_id, :name, :password)
  end

end