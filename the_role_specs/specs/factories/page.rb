FactoryBot.define do
  factory :page do
    title   { Faker::Lorem.sentence }
    content { Faker::Lorem.sentence }

    association :user, factory: :user
  end
end
