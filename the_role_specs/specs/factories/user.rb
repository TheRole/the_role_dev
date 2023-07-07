FactoryBot.define do
  factory :user do
    sequence(:email)   { |n| "testmail#{n}@mail.org" }
    password { 'qwerty' }
    password_confirmation { |u| u.password }
  end
end
