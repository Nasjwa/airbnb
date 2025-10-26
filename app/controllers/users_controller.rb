class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def user_flats
    @user_flats = current_user.flats
  end
end
