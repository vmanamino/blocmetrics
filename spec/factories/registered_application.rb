FactoryGirl.define do
  factory :registered_application do
    name 'my app'
    sequence(:url) { |n| "https://www.nitrous.io#{n}/ide/#/philter-108461" }
    user
  end
end
