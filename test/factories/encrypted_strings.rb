FactoryBot.define do
  factory :encrypted_string do
    sequence(:value) { |n| "value#{n}" }
  end
end

