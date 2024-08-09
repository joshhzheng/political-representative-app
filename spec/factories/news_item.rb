# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'Default Title' }
    link { 'http://example.com' }
    description { 'Default Description' }
    representative
    issue { NewsItem::ISSUES.sample }

    # You can define traits for additional customization
    trait :with_custom_ratings do
    end
  end
end

#
# FactoryBot.define do
#  factory :news_item do
#    sequence(:title) { |n| "The Title #{n}" }
#    sequence(:link) { |n| "website.com/#{n}" }
#    issue { ['Free Speech', 'Immigration', 'Terrorism'].sample }
#    representative
#  end
# end
