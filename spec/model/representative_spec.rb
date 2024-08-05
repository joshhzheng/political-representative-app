require 'rails_helper.rb'

describe 'Clicking a county should return a list of representatives' do 
  context 'clicking on a county' do
    it 'returns an array of representatives' do 
      stub_officials = [
        double('Google::Apis::CivicinfoV2::Official', name: 'Kamala D. Harris', address: nil,
               party: 'Democratic Party', photo_url: 'https://example.com/photo.jpg'),
        double('Google::Apis::CivicinfoV2::Official', name: 'Dianne Feinstein', address: nil,
               party: 'Democratic Party', photo_url: 'https://example.com/photo.jpg')
      ] 

      sample_info = double('Google::Apis::CivicinfoV2::RepresentativeInfoResponse')

      allow(sample_info).to receive_messages(officials: stub_officials)
      stub_offices = [
        double('Google::Apis::CivicinfoV2::Office', official_indices: [0, 1], division_id: 'ocd-division/county:example_county')
      ]

      allow(stub_offices[0]).to receive_messages(name: 'U.S. Senators')

      allow(sample_info).to receive_messages(offices: stub_offices)
      result = Representative.civic_api_to_representative_params(sample_info)

      expect(result.map(&:name)).to match_array(['Kamala D. Harris', 'Dianne Feinstein'])
      expect(result.size).to eq(2)
    end
  end
end

