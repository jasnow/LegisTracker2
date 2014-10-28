FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password 'password'
    password_confirmation 'password'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.zone.now
  end
end
