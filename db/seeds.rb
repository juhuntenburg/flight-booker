# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

airports = %w[
  ATL LAX ORD JFK
]

airports.each do |code|
  Airport.find_or_create_by!(name: code)
end

puts "Seeded #{Airport.count} airports."

def random_time_within_days(days)
  rand(days * 24 * 60).minutes.from_now
end

def random_duration
  [90, 120, 150, 180, 240, 300].sample # duration in minutes
end

airports = Airport.all.to_a
100.times do
  departure_airport, arrival_airport = airports.sample(2)
  Flight.create!(
    departure_airport: departure_airport,
    arrival_airport: arrival_airport,
    departure_time: random_time_within_days(2),
    duration: random_duration
  )
end

puts "Seeded #{Flight.count} flights."
