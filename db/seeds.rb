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
  ATL LAX ORD DFW DEN JFK SFO SEA LAS MCO
  CLT EWR PHX MIA IAH BOS MSP DTW FLL PHL
  LGA BWI SLC DCA SAN MDW TPA HNL IAD DAL
  HOU AUS OAK RDU SMF SJC SNA STL PIT MCI
  CLE CMH PDX MKE BNA MSY RSW SAT IND JAX
]

airports.each do |code|
  Airport.find_or_create_by!(name: code)
end

puts "Seeded #{Airport.count} airports."
