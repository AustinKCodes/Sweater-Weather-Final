class Api::V1::MunchiesController < ApplicationController
  def index
    #binding.pry
    location = LocatorService.get_location(params[:destination])
    forecast_data = WeatherService.get_weather(location)
    restaurant_data = SearchService.find_restaurants(show_params[:destination], show_params[:food])

    render json: MunchiesSerializer.new(location, forecast_data, restaurant_data)
  end

  private

  def show_params
    params.permit(:food, :destination)
  end
end