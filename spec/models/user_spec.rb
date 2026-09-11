require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(name: "Test User", email: "test@example.com", password: "password123")
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = User.new(name: "Test User", password: "password123")
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email" do
    User.create!(name: "First User", email: "dupe@example.com", password: "password123")
    user = User.new(name: "Second User", email: "dupe@example.com", password: "password123")
    expect(user).not_to be_valid
  end

  it "authenticates with the correct password" do
    user = User.create!(name: "Test User", email: "auth@example.com", password: "password123")
    expect(user.authenticate("password123")).to be_truthy
  end

  it "does not authenticate with the wrong password" do
    user = User.create!(name: "Test User", email: "auth2@example.com", password: "password123")
    expect(user.authenticate("wrongpassword")).to be_falsey
  end
end
