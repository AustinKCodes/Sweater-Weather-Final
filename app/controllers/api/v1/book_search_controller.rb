class Api::V1::BookSearchController < ApplicationController
  def show
    location = params[:location]
    quantity = params[:quantity].to_i

    if quantity <= 0
      render json: { error: "Quantity must be greater than 0" }, status: 400
      return
    end

    coordinates = LocatorService.get_location(location)
    forecast = WeatherService.get_weather(coordinates[:lat], coordinates[:lng])

    books = BookSearchService.search_books(location, quantity)

    render json: BookSearchSerializer.new(location, forecast, books)
  end
end