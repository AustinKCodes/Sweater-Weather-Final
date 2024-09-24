class Api::V1::ForecastController < ApplicationController
  def show
    location = LocatorService.get_location(show_params[:location])
    forecast_data = WeatherService.get_weather(location)
    render json: ForecastSerializer.new(forecast_data).serialized_json
  end

  private

  def show_params
    params.permit(:location)
  end
end