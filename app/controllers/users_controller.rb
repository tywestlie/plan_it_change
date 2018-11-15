class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :update]
  before_action :authorize_as_admin, only: [:destroy]
end
