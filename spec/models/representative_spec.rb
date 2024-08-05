# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'google/apis/civicinfo_v2'

describe Representative do
  describe 'Representative' do
    let(:two_officials) do
      [
        instance_double(Google::Apis::CivicinfoV2::Official, name: 'John Doe', address: [], party: '0', photo_url: ''),
        instance_double(Google::Apis::CivicinfoV2::Official, name: 'Jane Smith', address: [], party: '1', photo_url: '')
      ]
    end
    let(:two_offices) do
      [
        instance_double(Google::Apis::CivicinfoV2::Office, name: 'Senator', division_id: 'ocd-1234',
                        official_indices: [0]),
        instance_double(Google::Apis::CivicinfoV2::Office, name: 'Representative', division_id: 'ocd-5678',
                        official_indices: [1])
      ]
    end
    let(:rep_info) do
      instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse,
                      officials: two_officials, offices: two_offices)
    end

    before do
      described_class.civic_api_to_representative_params(rep_info)
    end

    context 'when making an API call' do
      it 'stores correct data count' do
        p described_class
        expect(described_class.count).to eq(two_officials.count)
      end

      it 'saves correct count of given names' do
        expect(described_class.where(name: two_officials[0].name).count).to eq 1
        expect(described_class.where(name: two_officials[1].name).count).to eq 1
      end

      it 'saves added representative data' do
        representative1 = described_class.find { |rep| rep.name == two_officials[0].name }
        expect(representative1).to be_present
        expect(representative1.title).to eq(two_offices[0].name)
        expect(representative1.ocdid).to eq(two_offices[0].division_id)
      end

      it 'will not create duplicates' do
        duplicate_representative_call = described_class.civic_api_to_representative_params(rep_info) # second call
        expect(duplicate_representative_call.size).to eq(2)
      end

      it 'will not alter existing database count' do
        expect(described_class.count).to eq(two_officials.count)
      end

      it 'updates models with new value' do
        representative_name = two_officials[0].name
        new_office = 'Judge'

        described_class.find_by(name: representative_name).update(title: new_office)
        expect(described_class.find_by(name: representative_name).title).to eq(new_office)
      end
    end
  end
end
