FactoryBot.define do
  factory :performer do
    name { Faker::Name.name }
    introduction { Faker::Matz.quote }
    instrument

    trait :blank_introduction do
      introduction { '' }
    end
  end
end
