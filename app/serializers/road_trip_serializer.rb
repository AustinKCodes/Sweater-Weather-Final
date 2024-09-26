class RoadTripSerializer

  def initialize(road_trip)
    @road_trip = road_trip
  end
  def serialized_json
    {
      data: {
          id: nil,
          type: "road_trip",
          attributes: {
            start_city: @road_trip.start_city,
            end_city: @road_trip.end_city,
            travel_time: @road_trip.travel_time,
            weather_at_eta: @road_trip.weather_at_eta
          }
      }
    }
  end
end