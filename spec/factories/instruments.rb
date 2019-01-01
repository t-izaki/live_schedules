FactoryBot.define do
  factory :instrument do
    name { Faker::Music.unique.instrument }
    color { Faker::Color.hex_color }
  end
end
