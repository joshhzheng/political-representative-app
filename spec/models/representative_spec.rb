# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  subject do
    described_class.new(
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

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
