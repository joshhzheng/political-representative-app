# frozen_string_literal: true

require 'rails_helper'

# Two tests for correct count of articles by servie
# TODO not sure how to test if returned articles match query
# TODO could test that desired fields are present

RSpec.describe NewsAPIService do
  let(:api_key) { 'test_api_key' }
  let(:news_service) { described_class.new(api_key) }
  let(:news_double) { instance_double(News) }

  before do
    allow(News).to receive(:new).and_return(news_double)
  end

  describe '#fetch_top_articles' do
    context 'when fewer than 5 articles are returned' do
      let(:articles) do
        2.times.map do |i|
          OpenStruct.new(title:       "Top Article #{i + 1}",
                         description: "Description #{i + 1}",
                         url:         "http://example.com/articles#{i + 1}")
        end
      end

      before do
        allow(news_double).to receive(:get_top_headlines).and_return(articles)
      end

      it 'fetches all top articles' do
        result = news_service.fetch_top_articles('John Doe', 'Climate Change')
        expect(result.length).to eq(2)
        expect(result.first.title).to eq('Top Article 1')
      end
    end

    context 'when more than 5 articles are returned' do
      let(:articles) do
        6.times.map do |i|
          OpenStruct.new(title:       "Top Article #{i + 1}",
                         description: "Description #{i + 1}",
                         url:         "http://example.com/articles#{i + 1}")
        end
      end

      before do
        allow(news_double).to receive(:get_top_headlines).and_return(articles)
      end

      it 'fetches 5 top articles' do
        result = news_service.fetch_top_articles('John Doe', 'Climate Change')
        expect(result.length).to eq(5)
        expect(result.first.title).to eq('Top Article 1')
        expect(result.last.title).to eq('Top Article 5')
      end
    end
  end
end
