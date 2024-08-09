# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

## TODO: refactor to use representative and news item factory methods

RSpec.describe Rating, type: :model do
  let(:representative) { Representative.create!(name: 'Jane Doe') }
  let(:news_item) do
    NewsItem.create!(representative: representative, title: 'Breaking News', link: 'https://example.com',
                     issue: 'Free Speech')
  end

  context 'when creating ratings' do
    it 'is valid with valid attributes' do
      rating = news_item.ratings.build(score: 5, comment: 'Great article!')
      expect(rating).to be_valid
    end

    it 'is not valid without a score' do
      rating = news_item.ratings.build(comment: 'Great article!')
      expect(rating).not_to be_valid
    end

    it 'is not valid with a score outside 1-5' do
      rating = news_item.ratings.build(score: 6, comment: 'Great article!')
      expect(rating).not_to be_valid
    end

    it 'is valid without a comment' do
      rating = news_item.ratings.build(score: 4)
      expect(rating).to be_valid
    end
  end

  it 'belongs to a news item' do
    rating = news_item.ratings.create!(score: 5, comment: 'Great article!')
    expect(rating.news_item).to eq(news_item)
  end

  it 'understands valid ratings' do
    expect(described_class.rating_scores).to eq(Array(1..5))
  end
end
