# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
<<<<<<< HEAD
    name { 'John Doe' } # Default name
    ocdid { 'ocd-division/country:us/state:ny' } # Default OCD ID
    title { 'Senator' } # Default title
    address { '123 Main St, New York, NY 10001' } # Default address
    party { 'Independent' } # Default party
    photo { 'http://example.com/photo.jpg' } # Default photo URL
=======
    sequence(:name) { |n| "Marly Politician #{n}" }
>>>>>>> 0d2203c0c29435b0350601b1b9e6ed723d85a37d
  end
end
