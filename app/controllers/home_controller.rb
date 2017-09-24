class HomeController < ApplicationController
  def home

  end

  # GET /login
  def login

  end

  # POST /login
  def user_login
    # get user based on email id passed
    @user = User.find(params[:email_id])

    # set user id into session
    session[:current_user] = @user

    # redirect to dashboard
    redirect_to dashboard_path
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

    # redirect to dashboard
    redirect_to dashboard_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:email_id, :name, :password)
  end

end