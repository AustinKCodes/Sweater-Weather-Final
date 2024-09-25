require "rails_helper"

RSpec.describe "Sessions for logging in" do
  it "should return a 2xx status" do
    user1 = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    post "/api/v1/sessions", params: { email: "test@example.com", password: "password", password_confirmation: "password" }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq(user1.id.to_s)
    expect(json[:data][:type]).to eq("users")
    expect(json[:data][:attributes][:email]).to eq(user1.email)
    expect(json[:data][:attributes][:api_key]).to eq(user1.api_key)
  end

  it "should return a 4xx status when given bad params" do
    user1 = User.create!(email: "test@example.com", password: "password", password_confirmation: "password")
    post "/api/v1/sessions", params: { email: "test@example.com", password: "passwor", password_confirmation: "password" }

    expect(response).to have_http_status(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error][:message]).to eq("Incorrect Username/Password")
  end
end