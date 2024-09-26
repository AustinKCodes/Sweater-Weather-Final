class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(start_city, end_city, travel_time, weather_data)
    @start_city = start_city
    @end_city = end_city
    @travel_time = travel_time[:route][:formattedTime]
    @weather_at_eta = eta_weather(travel_time, weather_data)
  end
  
  def eta_weather(time, weather_data)
    eta = time_math(time)
    weather_data[:forecast][:forecastday].each do |day|
      forecast = day[:hour].find do |hour|
        hour[:time] == eta
      end
      
      if forecast
        return {
          datetime: forecast[:time], temperature: forecast[:temp_f], condition: forecast[:condition][:text]
        }
      else
        "No weather available for this time"
      end
    end
  end
  
  def time_math(time)
    eta = Time.now + time[:route][:realTime]
    rounded_eta = 0
    if eta.min >= 30 
      rounded_eta = eta + (3600 - eta.min * 60 - eta.sec)

    else 
      rounded_eta = eta - (eta.min * 60 - eta.sec)
    end
    rounded_eta.strftime("%Y-%m-%d %H:00")
  end
end