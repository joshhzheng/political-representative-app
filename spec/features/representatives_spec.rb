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
    visit representative_path(@representative)
  end

  it 'User views a representative name and title' do
    expect(page).to have_content(@representative.name)
    expect(page).to have_content(@representative.title)
  end

  it 'User views a representative address, party, photo' do
    expect(page).to have_content(@representative.address)
    expect(page).to have_content(@representative.party)
    expect(page).to have_selector("img[src='#{@representative.photo}']")
  end
end
