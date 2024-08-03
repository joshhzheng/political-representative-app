# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'google/apis/civicinfo_v2'

describe Representative do
  describe 'check API call for Representative models' do
    let(:officials) do
      [
        instance_double(Google::Apis::CivicinfoV2::Official, name: 'John Doe'),
        instance_double(Google::Apis::CivicinfoV2::Official, name: 'Jane Smith')
      ]
    end
    let(:offices) do
      [
        instance_double(Google::Apis::CivicinfoV2::Office, name: 'Senator', division_id: 'ocd-1234',
official_indices: [0]),
        instance_double(Google::Apis::CivicinfoV2::Office, name: 'Representative', division_id: 'ocd-5678',
official_indices: [1])
      ]
    end
    let(:rep_info) do
      instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse, officials: officials, offices: offices)
    end

    before do
      @reps = described_class.civic_api_to_representative_params(rep_info)
    end

    it 'checks if the models save data from API call' do
      expect(@reps.count).to eq(2)
      expect(described_class.count).to eq(2)
      expect(described_class.where(name: 'John Doe').count).to eq 1
      expect(described_class.where(name: 'Jane Smith').count).to eq 1
    end

    it 'checks if the models saved correctly' do
      # r = @reps.find { |rep| rep.name == 'John Doe' }
      r = described_class.find { |rep| rep.name == 'John Doe' }
      expect(r).to be_present
      expect(r.title).to eq('Senator')
      expect(r.ocdid).to eq('ocd-1234')
    end

    it 'checks if reps already exists in db' do
      # p described_class.all
      @reps = described_class.civic_api_to_representative_params(rep_info) # second call
      expect(@reps.size).to eq(2)
      expect(described_class.count).to eq(2)
      # p described_class.all
      expect(described_class.where(name: 'John Doe').count).to eq 1
      expect(described_class.where(name: 'Jane Smith').count).to eq 1
    end

    it 'checks if models updated with new value'
    it 'checks if value is nil'
  end
end
