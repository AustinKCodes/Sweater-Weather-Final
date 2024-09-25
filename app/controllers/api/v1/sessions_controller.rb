class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: ErrorSerializer.serialize(ErrorMessage.new("Incorrect Username/Password", 400)), status: 400
    end
  end
end