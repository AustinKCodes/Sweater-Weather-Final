require "rails_helper"

RSpec.describe "Forecast API" do
  describe " get /api/v1/forecast" do
    before do
      allow(LocatorService).to receive(:get_location).and_return({lat: 39.1031, lng: -84.5120})

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
    end

    it "returns the weather for a given city" do
      get "/api/v1/forecast", params: {location: "cincinnati,oh" }

      expect(response).to be_successful
      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data][:type]).to eq("forecast")
      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(forecast[:data][:attributes][:daily_weather].length).to eq(1)
      expect(forecast[:data][:attributes][:hourly_weather].length).to eq(5)
    end
  end
end