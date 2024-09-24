class SearchService
  def self.conn
    Faraday.new("https://api.yelp.com", headers: { 
      Authorization: "Bearer #{Rails.application.credentials.yelp[:key]}"})
  end

  def self.find_restaurants(location, food)
    response = conn.get("/v3/businesses/search") do |req|
      req.params["q"] = food
      req.params["location"] = location
      req.params["limit"] = 1
    end
    data = JSON.parse(response.body, symbolize_names: true)
    business = data[:businesses].first
    #binding.pry
  end
end