# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  before do
    @representative = Representative.create!(
      name:    'John Doe',
      ocdid:   'ocd-division/country:us/state:ca/sldl:12',
      title:   'Assembly Member',
      address: '123 Main St',
      party:   'Democratic',
      photo:   'https://example.com/photo.jpg'
    )
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: @representative.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:representative)).to eq(@representative)
    end
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(assigns(:representatives)).to include(@representative)
    end
  end
end
