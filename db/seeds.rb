# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "🧹 Clearing existing data..."
Flat.destroy_all
User.destroy_all

puts "👤 Creating a fake user..."
user = User.create!(email: "test@example.com", password: "password")

puts "🏠 Seeding fake flats..."
30.times do
  Flat.create!(
    location: Faker::Address.city,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    photo: Faker::LoremFlickr.image(size: "600x400", search_terms: ['apartment', 'flat']),
    user: user
  )
end

puts "✅ Done! Created #{Flat.count} fake flats for user #{user.email}."
