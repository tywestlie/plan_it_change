class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user, only: [:update, :create]

  def show

  end

  def index
  end

  def update
  end

  def create
  end

  def destroy
  end
end
