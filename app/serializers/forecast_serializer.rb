class ForecastSerializer
  def initialize(forecast_data)
    @forecast_data = forecast_data
  end

  def serialized_json
    {
      data: {
        id: nil,
        type: "forecast",
        attributes: {
          current_weather: current_weather,
          daily_weather: daily_weather,
          hourly_weather: hourly_weather
        }
      }
    }
  end

  private

  def current_weather
    {
      last_updated: @forecast_data[:current][:last_updated],
      temperature: @forecast_data[:current][:temp_f],
      feels_like: @forecast_data[:current][:feelslike_f],
      humidity: @forecast_data[:current][:humidity],
      uvi: @forecast_data[:current][:uv],
      visibility: @forecast_data[:current][:vis_miles],
      condition: @forecast_data[:current][:condition][:text],
      icon: @forecast_data[:current][:condition][:icon]
    }
  end

  def daily_weather
    @forecast_data[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintime_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def hourly_weather
    @forecast_data[:forecast][:forecastday].first[:hour].map do |hour|
      {
        time: hour[:time].split(" ")[1],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end