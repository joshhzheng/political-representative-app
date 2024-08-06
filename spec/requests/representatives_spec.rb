# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Representatives', type: :request do
  before do
    @representative = Representative.create!(
      name:    'John Doe',
      ocdid:   'ocd-division/country:us/state:ca/sldl:12',
      title:   'Assembly Member',
      address: '123 Main St Sacramento CA 95814',
      party:   'Democratic',
      photo:   'https://example.com/photo.jpg'
    )
  end

  describe 'GET /representatives/:id' do
    before do
      get representative_path(@representative)
    end

    it 'returns the representative name and title' do
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(@representative.name)
      expect(response.body).to include(@representative.title)
    end

    it 'returns the representative address, party, photo' do
      expect(response.body).to include(@representative.address)
      expect(response.body).to include(@representative.party)
      expect(response.body).to include(@representative.photo)
    end
  end
end
