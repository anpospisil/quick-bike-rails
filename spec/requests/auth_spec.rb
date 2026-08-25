require "rails_helper"

RSpec.describe "Auth", type: :request do
  describe "POST /login" do
    before do
      User.create!(name: "Test User", email: "login@example.com", password: "password123")
    end

    it "logs in with correct credentials and returns a token" do
      post "/login", params: { email: "login@example.com", password: "password123" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["token"]).to be_present
    end

    it "rejects incorrect password" do
      post "/login", params: { email: "login@example.com", password: "wrongpassword" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end