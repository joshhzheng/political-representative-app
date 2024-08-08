# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'google/apis/civicinfo_v2'

describe NewsItem do
  let(:news_info) { {representative_id:1, title:"The Title", link:"website.com",
                     issue:"Free Speech"} }
  let(:news_article1) { described_class.create(news_info) }

  context 'creates a news item' do
    it 'that is not nil' do
      expect(news_article1).should_not be_nil
    end

    context 'with the correct' do
      it 'representative ID' do
        expect(news_article1.representative_id).to eq(news_info[:representative_id])
      end
      it 'title' do
        expect(news_article1.title).to eq(news_info[:title])
      end
      it 'link' do
        expect(news_article1.link).to eq(news_info[:link])
      end
      it 'issue' do
        expect(news_article1.issue).to eq(news_info[:issue])
      end
    end
  end
end
