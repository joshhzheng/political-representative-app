# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'google/apis/civicinfo_v2'

describe NewsItem do
  let(:representative) { Representative.create({ name: 'Jane Smith', id: 1 }) }
  let(:news_info) do
    { representative_id: representative[:id], title: 'The Title', link: 'website.com',
                     issue: 'Free Speech' }
  end
  let!(:news_article) { described_class.create!(news_info) }

  context 'when creating an item' do
    it 'that is valid' do
      expect(news_article).to be_valid
      expect(news_article).not_to be_nil
      expect(news_article.errors.full_messages).to be_empty
    end

    context 'with the correct attribute' do
      it 'representative ID' do
        expect(news_article.representative_id).to eq(news_info[:representative_id])
      end

      it 'title' do
        expect(news_article.title).to eq(news_info[:title])
      end

      it 'link' do
        expect(news_article.link).to eq(news_info[:link])
      end

      it 'issue' do
        expect(news_article.issue).to eq(news_info[:issue])
      end
    end
  end

  it 'saves the correct count of articles' do
    expect(described_class.count).to eq(1)
  end

  context 'when associated with a representative ID' do
    let(:representative_articles_search) { described_class.find_for(representative.id) }

    it 'finds a news article with by representative ID' do
      expect(representative_articles_search).to eq(news_article)
    end

    it 'associated with the correct issue' do
      expect(representative_articles_search.issue).to eq(news_article.issue)
    end
  end
end
