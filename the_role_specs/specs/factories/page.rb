FactoryBot.define do
  factory :page do
    title   { Faker::Lorem.sentence }
    content { Faker::Lorem.sentence }
  end
end
