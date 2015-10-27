FactoryGirl.define do

  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    role_sid 'user'
    password 'password'
    password_confirmation 'password'
  end
end
