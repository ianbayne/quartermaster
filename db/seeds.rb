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

  duration = (1..10).to_a.sample
  contract = Contract.new(duration: Time.now, price: (1..10_000).to_a.sample)
  contract.equipment = equipment
  no_users = User.count
  random_id = (1..no_users).to_a.sample  # Chance of selecting equipment owned by self, however...
  contract.user = User.find(random_id)
  contract.save
end



puts "Seeds finished!"
