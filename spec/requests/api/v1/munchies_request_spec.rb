require "rails_helper"

RSpec.describe "Munchies API" do
  describe "get /api/v1/munchies" do
    let(:location) { "Denver, CO" }
    let(:food) { "italian" }
    let(:forecast_data) { { summary: "Sunny", temperature: "75" } }
    let(:restaurant_data) { { name: "Tavernetta",
                            address: "1889 16th St, Denver, CO 80202",
                            raitng: 4.5,
                            reviews: 767 } }
    before do
      allow(LocatorService).to receive(:get_location).and_return(location)
      allow(WeatherService).to receive(:get_weather).and_return(forecast_data)
      allow(SearchService).to receive(:find_restaurants).and_return(restaurant_data)
    end

    it "should return a successful response" do
      get "/api/v1/munchies?location=denver%2C%20co&food=#{food}"
      binding.pry
      expect(response).to have_http_status(:success)
    end
  end
end