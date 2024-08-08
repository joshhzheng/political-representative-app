# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'google/apis/civicinfo_v2'

describe NewsItem do
  let(:news_info) { {representative_id:1, title:"Title", link:"website.com",
                     issue:"Free Speech"} }
  it 'creates a news item' do
    news1 = described_class.create(news_info)
    expect(news1.issue).should_not be_nil
  end
end
