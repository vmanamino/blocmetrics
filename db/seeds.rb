require 'faker'

# create users
5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password'
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
registered_apps = RegisteredApplication.all

20.times do
  event = Event.create!(
    name: Faker::Name.name,
    registered_application: registered_apps.sample
    )
end

puts 'Seeding finished'
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered applications created"
puts "#{Event.count} events created"