class SearchService
  def self.conn
    Faraday.new("https://api.yelp.com", headers: { 
      Authorization: "Bearer #{Rails.application.credentials.yelp[:key]}"})
  end
end