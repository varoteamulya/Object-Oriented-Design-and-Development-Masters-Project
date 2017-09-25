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
      redirect_to login_path
    end
  end

  # GET /sign_up
  def sign_up
    @user = User.new
  end

  # POST /sign_up
  def user_sign_up
    puts params

    params_to_pass = user_params()

    params_to_pass[:u_type] = 3
    puts params_to_pass

    # create new user
    @user = User.new(params_to_pass)
    @user.save

    # set user id into session
    session[:current_user] = @user

    UserNotifierMailer.send_sign_up_email(@user).deliver_now

    # redirect to dashboard
    redirect_to dashboard_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def login_params
    params.require(:login).permit(:email_id, :name, :password)
  end

  def user_params
    params.permit(:email_id, :name, :password)
  end

end