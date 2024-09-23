class Api::V1::BookSearchcontroller < ApplicationController
  def show
    location = params[:location]
    quantity = params[:quantity].to_i

    if quantity <= 0
      render json: { error: "Quantity must be greater than 0" }, status: 400
      return
    end

    forecast = WeatherService.get_weather(location)

    books = BookSearchService.search_books(location, quantity)

    render json: BookSearchSerializer.new(location, forecast, books)
  end
end