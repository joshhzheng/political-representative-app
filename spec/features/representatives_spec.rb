# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Representatives', type: :feature do
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

  it 'User views a representative profile' do
    visit representative_path(@representative)
    expect(page).to have_content(@representative.name)
    expect(page).to have_content(@representative.title)
    expect(page).to have_content(@representative.address)
    expect(page).to have_content(@representative.party)
    # expect(page).to have_selector("img[src='#{@representative.photo_url}']")
  end
end
