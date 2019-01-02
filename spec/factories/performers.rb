FactoryBot.define do
  factory :performer do
    name { Faker::Name.unique.name }
    introduction { Faker::Lorem.paragraph }
    image_url { Faker::Internet.url }
    icon_url { Faker::Internet.url }
    instrument

    trait :blank_introduction do
      introduction { '' }
    end
  end
end
