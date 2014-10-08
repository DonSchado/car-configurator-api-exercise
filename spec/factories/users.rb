FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}@mycars.com" }
    password 'secret'
    level 1
    permission true
  end
end
