
FactoryBot.define do
  factory :representative do
    sequence(:name) { |n| "Marly Politician #{n}" }
  end
end
