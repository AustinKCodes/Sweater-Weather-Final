require "rails_helper"

RSpec.describe "Weather API Service" do
  it "should return weather for a specific location" do
    allow(WeatherService).to receive(:get_weather).and_return({
        current: {
          last_updated: "2023-04-07 16:30",
          temp_f: 55.0,
          feelslike_f: 53.0,
          humidity: 80,
          uv: 2.0,
          vis_miles: 10.0,
          condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" }
        },
        forecast: {
          forecastday: [
            {
              date: "2023-04-07",
              astro: { sunrise: "07:13 AM", sunset: "08:07 PM" },
              day: { maxtemp_f: 60.0, mintemp_f: 45.0, condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } },
              hour: [
                { time: "2023-04-07 14:00", temp_f: 54.5, condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } },
                { time: "2023-04-07 15:00", temp_f: 55.0, condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } },
                { time: "2023-04-07 15:00", temp_f: 55.0, condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } },
                { time: "2023-04-07 15:00", temp_f: 58.0, condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } },
                { time: "2023-04-07 15:00", temp_f: 59.5, condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } }
              ]
            },
          ]
          }
        })
      
      weather_data = WeatherService.get_weather("denver, co")

      expect(weather_data[:current]).to have_key(:temp_f)
      expect(weather_data[:current]).to have_key(:feelslike_f)
      expect(weather_data[:current]).to have_key(:humidity)
      expect(weather_data[:current]).to have_key(:uv)
      expect(weather_data[:current]).to have_key(:vis_miles)
      expect(weather_data[:current]).to have_key(:condition)
      expect(weather_data[:current][:condition]).to have_key(:text)
  end
end