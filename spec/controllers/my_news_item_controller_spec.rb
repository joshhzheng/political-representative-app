# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let(:representative) { create(:representative) }
  let(:issue) { 'Climate Change' }
  let(:top_articles) do
    5.times.map do |i|
      OpenStruct.new(title:       "Top Article #{i + 1}",
                     description: "Description #{i + 1}",
                     url:         "http://example.com/articles#{i + 1}")
    end
  end

  before do
    service = instance_double(NewsAPIService)
    allow(NewsAPIService).to receive(:new).and_return(service)
    allow(service).to receive(:fetch_top_articles).and_return(top_articles)
  end

  describe 'GET #search_top_articles' do
    it 'fetches the top articles based on the representative name and issue' do
      get :search_top_articles, params: { representative_id: representative.id, issue: issue }

      expect(assigns(:representative_name)).to eq(representative.name)
      expect(assigns(:top_articles)).to eq(top_articles)
    end

    it 'redirects to the top5search_path' do
      get :search_top_articles, params: { representative_id: representative.id, issue: issue }

      expect(response).to redirect_to(top5search_path)
    end
  end
end
