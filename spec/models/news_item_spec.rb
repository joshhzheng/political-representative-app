# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'google/apis/civicinfo_v2'

describe NewsItem do
  let(:one_representative) { FactoryBot.create_list(:representative, 1).first }
  let(:five_representatives) { FactoryBot.create_list(:representative, 5) }
  let(:one_news_item) { FactoryBot.create(:news_item, representative: one_representative) }
  let(:ten_news_item) do
    10.times do |i|
      described_class.create(:news_item, representative: five_representatives.map(&:id))
    end
  end

  context 'when creating an item' do
    it 'that is valid' do
      expect(one_news_item).to be_valid
      expect(one_news_item).not_to be_nil
      expect(one_news_item.errors.full_messages).to be_empty
    end

    context 'can search the database by' do
      it 'representative ID' do
        expect(described_class.find_by(representative_id: one_news_item.id)) \
          .to eq(one_news_item)
      end

      it 'title' do
        expect(described_class.find_by(title: one_news_item.title)) \
          .to eq(one_news_item)
      end

      it 'link' do
        expect(described_class.find_by(link: one_news_item.link)) \
          .to eq(one_news_item)
      end

      it 'issue' do
        expect(described_class.find_by(issue: one_news_item.issue)) \
          .to eq(one_news_item)
      end
    end
  end

  it 'saves the correct count of articles' do
    one_news_item
    expect(described_class.count).to eq(1)
  end

  context 'when associated with a representative ID' do
    let(:representative_articles_search) {
      one_news_item
      described_class.find_for(one_representative.id)
    }

    it 'finds a news article with by representative ID' do
      expect(representative_articles_search).to eq(one_news_item)
    end

    it 'associated with the correct issue' do
      expect(representative_articles_search.issue).to eq(one_news_item.issue)
    end
  end

  before do

  end
  context 'when searching by issue' do
    it 'returns news items with that issue' do

    end
  end
end
