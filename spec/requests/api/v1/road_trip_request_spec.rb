require "rails_helper"

RSpec.describe "Road Trip API" do
  before :each do
    @user1 = User.create!(email: "user1@example.com", password: "password", password_confirmation: "password")

    allow(LocatorService).to receive(:get_location).and_return({lat: 39.1031, lng: -84.5120})
    allow(LocatorService).to receive(:get_directions).and_return({ route: {  realTime: 60477,
        distance: 1192.7444,
        time: 59252,
        formattedTime: "04:20:07" } })

    allow(WeatherService).to receive(:get_weather).and_return({
        current: {
          last_updated: "2024-09-26 04:20",
          temp_f: 61.9,
          feelslike_f: 59,
          humidity: 80,
          uv: 2.0,
          vis_miles: 10.0,
          condition: { text: "Mist", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" }
        },
        forecast: {
          forecastday: [
            {
              date: "2024-09-26",
              astro: { sunrise: "07:13 AM", sunset: "08:07 PM" },
              day: { maxtemp_f: 65.0, mintemp_f: 45.0, condition: { text: "Mist", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } },
              hour: [
                { time: "2024-09-26 4:00", temp_f: 61.9, condition: { text: "Mist" } }
              ]
            },
          ]
          }
        })
  end

  it "should post and return a road trip" do
    post "/api/v1/road_trip", params: {
      "origin": "cincinnati, oh",
      "destination": "denver, co",
      "api_key": @user1.api_key
    }

    expect(response).to have_http_status(200)

    trip = JSON.parse(response.body, symbolize_names: true)
    expect(trip[:data][:id]).to eq(nil)
    expect(trip[:data][:type]).to eq("road_trip")
    expect(trip[:data][:attributes][:start_city]).to eq("cincinnati, oh")
    expect(trip[:data][:attributes][:end_city]).to eq("denver, co")
    expect(trip[:data][:attributes][:travel_time]).to eq("04:20:07")
    expect(trip[:data][:attributes][:weather_at_eta][:temperature]).to eq("61.9")
    expect(trip[:data][:attributes][:weather_at_eta][:condition]).to eq("Mist")
  end

  it "should return an error if the api key is invalid" do
    post "/api/v1/road_trip", params: {
      "origin": "cincinnati, oh",
      "destination": "denver, co",
      "api_key": "ajffsfksfkkaaf"
    }
    returns = JSON.parse(response.body, symbolize_names: true)[:error]
    expect(returns[:status]).to eq(401)
    expect(returns[:message]).to eq("Invalid API Key")
  end
end