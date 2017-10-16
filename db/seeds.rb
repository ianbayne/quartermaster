# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Making seeds"

6.times do
  user = User.create(email: Faker::Internet.email, password: "123456")
  adjective = %w(new old crappy like-new).sample
  category = ["tent", "stove", "cooking goods", "sleeping bag"].sample
  equipment = Equipment.new(name: "#{adjective} #{category}", description: Faker::Lorem.sentence, category: category, photo: nil)
  equipment.user = user
  equipment.save

  # contract = Contract.new()
end



puts "Seeds finished!"
