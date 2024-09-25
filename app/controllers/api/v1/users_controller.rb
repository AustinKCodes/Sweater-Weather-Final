class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    begin
      user.save!
      render json: UsersSerializer.new(user), status: 201
    rescue ActiveRecord::RecordInvalid => e
      render json: ErrorSerializer.serialize(ErrorMessage.new(e, 400)), status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end