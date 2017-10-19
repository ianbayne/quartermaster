# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Making seeds"

User.destroy_all
Equipment.destroy_all
Contract.destroy_all

user_num = 5
equipment_num = 15

tokyo_wards = User::LOCATION

puts "Seeding #{user_num} users"
i = 1
user_num.times do
  user = User.create(
    first_name: "first_name#{i}", last_name: "last_name#{i}",
    user_name: "user_name#{i}", location: tokyo_wards.sample,
    email: "test#{i}@mail.com", password: "123456")
  i+=1
end
puts "User seeds finished!"


puts "Seeding #{equipment_num} equipments"
puts "Some of them might be caught by google map API call limit."
equipment_num.times do
  adjective = %w(new old crappy like-new).sample
  category = ["tent", "stove", "cooking goods", "sleeping bag"].sample
  equipment = Equipment.new(name: "#{adjective} #{category}", 
                            description: Faker::Lorem.sentence, 
                            category: category,
                            price: (1..100).to_a.sample)
  # assign random user to equipment
  equipment.user = User.where('id >= ?', rand((User.first.id)..(User.last.id))).first
  
  if category == 'tent'
    url = "http://image-photos.linternaute.com/image_photo/640/camping-sauvage-1297554046-1337332.jpg"
  elsif category == "stove"
    url = "http://geared.jp/wp-content/uploads/2014/01/20140120_Vertex.jpg"
  elsif category == "cooking goods"
    url = "http://www.biz-garden.com/wp-content/uploads/2016/12/DSCF0678-500x454.jpg"
  else
    url = "http://www.coleman.eu/IT/images/Category/large/523.jpg"
  end
      
  equipment.remote_photo_url = url
  
  # by default equipment inherit address from user
  # equipment address should be manually overwritten
  equipment.address = equipment.user.location
  equipment.save!

  # contract = Contract.new(start_time: Time.now, end_time: Time.now, price: (1..10_000).to_a.sample)
  # contract.equipment = equipment
  # no_users = User.count
  # random_id = (1..no_users).to_a.sample  # Chance of selecting equipment owned by self, however...
  # contract.user = User.find(random_id)
  # contract.save
end
puts "Equipment seeds finished!"

