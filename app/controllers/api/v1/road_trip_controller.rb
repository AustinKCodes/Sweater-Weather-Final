class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      road_trip = RoadTripFacade.road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip).serialized_json
    else
      render json: ErrorSerializer.serialize(ErrorMessage.new("Invalid API Key", 401)), status: 401
    end
  end
end