FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'qwerty' }
    password_confirmation { |u| u.password }
  end
end
