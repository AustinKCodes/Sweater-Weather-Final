class RoadTripFacade
  def self.road_trip(origin, destination)
    location = LocatorService.get_location(destination)
    weather_data = WeatherService.get_weather(location)
    travel_time = LocatorService.get_directions(origin, destination)
    RoadTrip.new(origin, destination, travel_time, weather_data)

  end
end