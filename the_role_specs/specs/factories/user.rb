FactoryBot.define do
  factory :user do
    email   { Faker::Internet.email }
    password { 'qwerty' }
    password_confirmation { |u| u.password }
  end
end
