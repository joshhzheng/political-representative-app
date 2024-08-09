
FactoryBot.define do
  factory :news_item do
    sequence(:title) { |n| "The Title #{n}" }
    sequence(:link) { |n| "website.com/#{n}" }
    issue { ["Free Speech", "Immigration", "Terrorism"].sample }
    representative
  end
end
