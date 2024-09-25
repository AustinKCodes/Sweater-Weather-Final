class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    render json: UsersSerializer.new(user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end