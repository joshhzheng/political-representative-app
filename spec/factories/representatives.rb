FactoryBot.define do
  factory :representative do
    name { "John Doe" }             # Default name
    ocdid { "ocd-division/country:us/state:ny" }  # Default OCD ID
    title { "Senator" }             # Default title
    address { "123 Main St, New York, NY 10001" }  # Default address
    party { "Independent" }         # Default party
    photo { "http://example.com/photo.jpg" } # Default photo URL
  end
end
