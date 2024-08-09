FactoryBot.define do
  factory :news_item do
    title { 'Default Title' }
    link { 'http://example.com' }
    description { 'Default Description' }
    representative
    issue { 'Default Issue' }

    # You can define traits for additional customization
    trait :with_custom_ratings do
      after(:create) do |news_item|
        allow(news_item).to receive(:ratings).and_return(['Rating 1', 'Rating 2'])
      end
    end
  end
end