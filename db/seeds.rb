# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

puts "🧹 Clearing existing data..."
Flat.destroy_all
User.destroy_all

puts "👤 Creating a fake user..."
user = User.create!(email: "test@example.com", password: "password")


puts "Creating flats..."

flats = [
  {
    title: "A house",
    location: "Somewhere",
    description: "A classic house from the 80s.",
    image_url: "https://res.cloudinary.com/daadrtkvx/image/upload/v1761595690/OIP_1_ndfdls.jpg"
  },
   {
    title: "A house",
    location: "Somewhere",
    description: "A classic house from the 80s.",
    image_url: "https://res.cloudinary.com/daadrtkvx/image/upload/v1761593258/development/ic2b8lgwd65w5qd59q6h7ipyu0nv.webp"
  },
   {
    title: "A house",
    location: "Somewhere",
    description: "A classic house from the 80s.",
    image_url: "https://res.cloudinary.com/daadrtkvx/image/upload/v1761593845/development/o5nwuq37sc0sqpby2nqbllx42d5q.png"
  },
]

flats.each do |attrs|
  file = URI.open(attrs[:image_url])
  flat = Flat.create!(
    title: attrs[:title],
    location: attrs[:location],
    description: attrs[:description],
    user: user
  )
  flat.photo.attach(io: file, filename: "#{attrs[:title].parameterize}.jpg", content_type: "image/jpg")
  puts "Created #{flat.title}"
end

puts "✅ Done seeding!"
