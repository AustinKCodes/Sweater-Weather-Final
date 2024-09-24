class Api::V1::MunchiesController < ApplicationController
  def index
    location = LocatorService.get_location(show_params[:location])
    forecast_data = WeatherService.get_weather(location)
    restaurant = "unknown service class"

    render "something"
  end

  private

  def show_params
    params.permit(:location)
  end
end