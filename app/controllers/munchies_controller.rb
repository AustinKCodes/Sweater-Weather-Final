class Api::V1::MunchiesController < ApplicationController
  def index
    location = LocatorService.get_location(show_params[:location])
    forecast_data = WeatherService.get_weather(location)
    restaurant_data = SearchService.find_restaurants(location, show_params[:food])

    render json: MunchieSerializer.new(location, forecast_data, restaurant_data)
  end

  private

  def show_params
    params.permit(:location, :food)
  end
end