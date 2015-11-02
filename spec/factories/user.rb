FactoryGirl.define do
  factory :user do
    name 'Doug Adams'
    sequence(:email) { |n| "person#{n}@email.com" }
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now # rubocop:disable Rails/TimeZone
  end
end