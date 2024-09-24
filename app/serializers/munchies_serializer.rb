class MunchieSerializer
  def initialize(location, forecast_data, restaurant_data)
    @location = location
    @forecast_data = forecast_data
    @restaurant_data = restaurant_data
  end

  def serialized_json
    {
      data: {
        id: "nil",
        type: "munchie",
        attributes: {
          destination_city: @location,
          forecast: forecast,
          restaurant: restaurant
        }
      }
    }
  end

  private

  def forecast
    {
      summary: @forecast_data[:summary],
      temperature: @forecast_data[:temp_f]
    }
  end

  def restaurant
    {
      name: @restaurant_data[:name],
      address: @restaurant_data[:address],
      rating: @restaurant_data[:rating],
      reviews: @restaurant_data[:reviews]
    }
  end
end