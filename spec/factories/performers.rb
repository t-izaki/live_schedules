FactoryBot.define do
  factory :performer do
    name { Faker::Name.unique.name }
    introduction { Faker::Lorem.paragraph }
    regular { false }
    image_url { Faker::Internet.url }
    icon_url { Faker::Internet.url }
    instrument

    trait :regular do
      regular { true }
    end

    trait :blank_introduction do
      introduction { '' }
    end

    factory :regular_performer, traits: %i[regular]
  end
end
