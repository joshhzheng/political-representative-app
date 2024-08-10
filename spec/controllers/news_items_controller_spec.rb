# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe NewsItemsController, type: :controller do
  let(:representative) { Representative.create!(name: 'John Doe') }
  let(:news_item) do
    NewsItem.create!(representative: representative,
                     title:          'Test Title',
                     link:           'https://example.com',
                     issue:          'Free Speech')
  end

  describe 'GET #index' do
    it 'assigns @news_items' do
      news_item # Create the news_item to be included in @news_items
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq([news_item])
    end

    it 'renders the index template' do
      get :index, params: { representative_id: representative.id }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested news_item to @news_item' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
    end

    it 'renders the show template' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(response).to render_template(:show)
    end
  end
end
