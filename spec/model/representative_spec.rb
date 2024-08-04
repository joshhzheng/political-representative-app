describe 'Searching for representatives should return a list of representatives' do
  context 'searching for representatives' do
      it 'returns an array of representatives' do
          stub_official = [double('Google::Apis::CivicinfoV2::Official', name: 'Kamala D. Harris', address: nil,
                        party: 'Democratic Party', photo_url: '')]

          sample_info = double('Google::Apis::CivicinfoV2::RepresentativeInfoResponse')

          allow(sample_info).to receive_messages(officials: stub_official)
          stub_offices = [double('Google::Apis::CivicinfoV2::Office')]

          allow(stub_offices[0]).to receive_message_chain(:official_indices, include?: true)
          allow(stub_offices[0]).to receive_messages(name: 'Kamala D. Harris')
          allow(stub_offices[0]).to receive_messages(division_id: 'ocd-division/country:us')
          allow(sample_info).to receive_messages(offices: stub_offices)

          result = Representative.civic_api_to_representative_params(sample_info)

          expect(result[0].name).to eq('Kamala D. Harris') 
          expect(result.size).to eq(1) 
      end
  end
end