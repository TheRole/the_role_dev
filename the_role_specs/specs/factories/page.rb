FactoryBot.define do
  factory :page do
    sequence(:title)   { |n| Faker::Lorem.sentence + "#{n}" }
    content { Faker::Lorem.sentence }

    association :user, factory: :user
  end
end
