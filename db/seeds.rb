# db/seeds.rb

puts "Seeding users..."
users = [
  { name: "testuser", email: "test@test.com", password: "test1234", image_url: "https://p7.hiclipart.com/preview/340/956/944/computer-icons-user-profile-head-ico-download.jpg" },
  { name: "dummy",    email: "a@a.com",       password: "a",        image_url: "https://p7.hiclipart.com/preview/340/956/944/computer-icons-user-profile-head-ico-download.jpg" },
  { name: "jane",     email: "jane@mail.com", password: "asd123",   image_url: "https://p7.hiclipart.com/preview/340/956/944/computer-icons-user-profile-head-ico-download.jpg" },
  { name: "john",     email: "j@j.com",       password: "j",        image_url: "https://p7.hiclipart.com/preview/340/956/944/computer-icons-user-profile-head-ico-download.jpg" }
]

users.each do |attrs|
  User.create!(attrs)
end

puts "Seeding bikes..."
bikes = [
  { name: "jimmy",     latitude: 52.378877, longitude: 4.896858, reserved: false },
  { name: "joanne",    latitude: 52.368230, longitude: 4.913074, reserved: false },
  { name: "claudette", latitude: 52.358027, longitude: 4.892204, reserved: false },
  { name: "percy",     latitude: 52.365316, longitude: 4.873372, reserved: false },
  { name: "jip",       latitude: 52.385413, longitude: 4.917933, reserved: false },
  { name: "liza",      latitude: 52.376535, longitude: 4.884172, reserved: false }
]

bikes.each do |attrs|
  Bike.create!(attrs)
end

puts "Seeding reservations..."
first_user = User.first
first_bike = Bike.first

4.times do
  Reservation.create!(
    user: first_user,
    bike: first_bike,
    start_time: Time.current,
    end_time: Time.current,
    cost: 0
  )
end

puts "Done seeding!"
