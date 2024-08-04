require 'rails_helper'

RSpec.describe "Representatives", type: :request do
  before do
    @representative = Representative.create!(
      name: 'John Doe',
      ocdid: 'ocd-division/country:us/state:ca/sldl:12',
      title: 'Assembly Member',
      contact_address: '123 Main St',
      contact_city: 'Sacramento',
      contact_state: 'CA',
      contact_zip: '95814',
      political_party: 'Democratic',
      photo_url: 'https://example.com/photo.jpg'
    )
  end

  describe "GET /representatives/:id" do
    it "returns the representative profile page" do
      get representative_path(@representative)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(@representative.name)
      expect(response.body).to include(@representative.title)
      expect(response.body).to include(@representative.contact_address)
      expect(response.body).to include(@representative.contact_city)
      expect(response.body).to include(@representative.contact_state)
      expect(response.body).to include(@representative.contact_zip)
      expect(response.body).to include(@representative.political_party)
      expect(response.body).to include(@representative.photo_url)
    end
  end
end
