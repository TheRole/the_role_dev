FactoryBot.define do
  factory :user, class: User do
    email   { Faker::Internet.email }
    password { 'qwerty' }
    password_confirmation { |u| u.password }
  end
end
