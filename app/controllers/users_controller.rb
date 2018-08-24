class UsersController < ApplicationController

  def index

  end

  def create

  end

  def edit

  end

  def show
    @user = User.find(params[:id])
  end

  def destroy

  end
end
