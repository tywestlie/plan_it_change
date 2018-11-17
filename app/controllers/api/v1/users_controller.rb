class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user,   only: [:index, :show, :update]
  before_action :authorize_as_admin,  only: [:destroy]

  def index
    render json: { status: 200, msg: 'Logged in' }
  end

  def create
    user = User.new(user_params)
    if user.save
      render status: 200, json: { user: "#{user.email}", created: "Yes" }
    else 
      render status: 409, json: { user: "#{user.email}", created: "No", error: "User may already exist." }
    end
  end

  def update
    user = User.find(params[:id])
    if authorized? && user.update(user_params)
      render status: 200, json: { user: "#{user.email}", updated: "Yes" }
    else
      render status: 404, json: { error: "User with email - #{user.email} not found or is not authorized to update this account." }
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :city, :state, :password, :password_confirmation)
  end

  def authorized?
    true ? current_user && current_user.can_modify_user?(params[:id]) : false
  end
end