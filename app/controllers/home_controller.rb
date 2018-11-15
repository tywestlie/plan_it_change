class HomeController < ApplicationController
  before_action :authenticate_user, only: [:show

  def index
    render json: { service: 'auth-api', status: 200 }
  end

  def show
    render json: { status: 200, msg: "You are currently logged in as #{current_user.username}."}
  end

end
