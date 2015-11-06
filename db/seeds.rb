require 'faker'

# create users
5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# create registered applications
counter = 0
10.times do
  counter += 1
  app = RegisteredApplication.create!(
    name: Faker::Lorem.sentence,
    url: "http://nowhere#{counter}.com",
    user: users.sample
    )
end

puts 'Seeding finished'
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered applications created"