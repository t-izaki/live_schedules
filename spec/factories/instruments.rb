FactoryBot.define do
  factory :instrument do
    sequence(:name) { |n| "Instrument#{n}" }
    sequence(:color) { |n| "##{n.to_s * 6}" }
  end
end
