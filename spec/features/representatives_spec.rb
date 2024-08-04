# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Representatives', type: :feature do
  before do
    @representative = Representative.create!(
      name:            'John Doe',
      ocdid:           'ocd-division/country:us/state:ca/sldl:12',
      title:           'Assembly Member',
      contact_address: '123 Main St',
      contact_city:    'Sacramento',
      contact_state:   'CA',
      contact_zip:     '95814',
      political_party: 'Democratic',
      photo_url:       'https://example.com/photo.jpg'
    )
  end

  it 'User views a representative profile' do
    visit representative_path(@representative)
    expect(page).to have_content(@representative.name)
    expect(page).to have_content(@representative.title)
    expect(page).to have_content(@representative.contact_address)
    expect(page).to have_content(@representative.contact_city)
    expect(page).to have_content(@representative.contact_state)
    expect(page).to have_content(@representative.contact_zip)
    expect(page).to have_content(@representative.political_party)
    expect(page).to have_selector("img[src='#{@representative.photo_url}']")
  end
end
