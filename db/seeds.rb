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
equipment_num = 20

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
  category = ["tent", "stove", "cooking goods", "sleeping bag", "table"].sample
  equipment = Equipment.new(name: "#{adjective} #{category}", 
                            description: Faker::Lorem.sentence, 
                            category: category,
                            price: (5..30).to_a.sample)
  # assign random user to equipment
  equipment.user = User.where('id >= ?', rand((User.first.id)..(User.last.id))).first
  
  if category == 'tent'
    url = ["http://image-photos.linternaute.com/image_photo/640/camping-sauvage-1297554046-1337332.jpg",
      "http://i3.mirror.co.uk/incoming/article8095653.ece/ALTERNATES/s615b/North-Gear-Camping-Mars-Waterproof-4-Man-Dome-Tent.jpg"].sample
  elsif category == "stove"
    url = ["http://geared.jp/wp-content/uploads/2014/01/20140120_Vertex.jpg",
      "https://ae01.alicdn.com/kf/HTB1..3gKpXXXXahXVXXq6xXFXXXj/New-Camping-Stove-Outdoor-Stove-Cooking-Stove-Mountain-Stove-BRS-53.jpg"].sample
  elsif category == "cooking goods"
    url = ["http://www.biz-garden.com/wp-content/uploads/2016/12/DSCF0678-500x454.jpg",
      "https://ae01.alicdn.com/kf/HTB1_dPAh_AKL1JjSZFCq6xFspXaA/Tiartisan-BBQ-Grill-Mini-Portable-Wood-Stove-Outdoor-Camping-Wood-Burning-Stove-Pocket-Backpacking-Survival-Stove.jpg"].sample
  elsif category == "table"
    url = ["https://i.pinimg.com/originals/01/87/50/018750a657e1afc947a906908bcdc97e.jpg",
      "http://www.picnics4fun.com/shopimages/products/extras/hxpt8838b_1.jpg",
      "http://img1.cdn.tradew.com/Y201011M114C96/T6G3853619/W0H0/Folding+Table%2FCamping+Table%2FPicnic+Table+Aluminium+Portable+Folding+TABLES+Camping+Table+plastic+abs+table+portable+tables+foldable+table.jpg"].sample
  else
    url = ["http://www.coleman.eu/IT/images/Category/large/523.jpg",
      "https://outdoorgearlab-mvnab3pwrvp3t0.stackpathdns.com/photos/14/41/265667_12585_M2.jpg"].sample
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

