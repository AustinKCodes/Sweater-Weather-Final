class ForecastController < ApplicationController
  def show
    location = params[:location]
    coordinates = LocatorService.get_location(location)
    forecast_data = WeatherService.get_weather(coordinates[:lat], coordinates[:lng])

    render json: ForecastSerializer.new(forecast_data).serialized_json
  end
end