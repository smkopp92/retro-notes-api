class Api::V1::UsersController < ApplicationController
  before_action :set_headers
  skip_before_action :verify_authenticity_token

  def show
    render json: { user: session[:user] }
  end

  def create
    if request.env["omniauth.auth"]["info"]["teams"].select{|team| team["name"] == "Admins"}.any?
      session[:user] = request.env["omniauth.auth"]["info"]["first_name"]
    else
      session[:user] = nil
    end
    redirect_to "http://localhost:3000"
  end

  def failure
    redirect_to "http://localhost:3000"
  end

  def sign_in
    redirect_to "http://localhost:3002/auth/launch_pass"
  end

  def destroy
    session[:user] = nil
    redirect_to "http://localhost:3000"
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = "http://localhost:3000"
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, PATCH, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Include, Origin, X-Requested-With, Content-Type, Accept, Authorization, http://localhost:3000'
  end
end
