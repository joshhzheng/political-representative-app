# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

describe SearchController do
  describe 'search controller behavior' do
    let(:fake_address) { 'user_inputted_state' }
    let(:fake_service) { instance_double(Google::Apis::CivicinfoV2::CivicInfoService) }
    let(:fake_api_key) { 'API_from_google' }
    let(:fake_response) { instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse) }
    let(:fake_results) { [instance_double(Representative)] }

    # https://stackoverflow.com/questions/50933835/rspec-how-to-expect-received-message-without-stubbing-anything-or-changing-anyt
    before do
      allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new)
        .and_return(fake_service)
      allow(Rails.application.credentials).to receive(:[]).with(:GOOGLE_API_KEY)
                                                          .and_return(fake_api_key)
      allow(fake_service).to receive(:key=).with(fake_api_key)
      allow(fake_service).to receive(:representative_info_by_address)
        .with(address: fake_address).and_return(fake_response)
      allow(Representative).to receive(:civic_api_to_representative_params)
        .with(fake_response).and_return(fake_results)
    end

    describe 'when address is filled' do
      before do
        get :search, params: { address: fake_address }
      end

      it 'creates API object' do
        expect(Google::Apis::CivicinfoV2::CivicInfoService).to have_received(:new)
      end

      it 'uses correct API key' do
        expect(fake_service).to have_received(:key=).with(fake_api_key)
      end

      it 'calls API method with params address' do
        expect(fake_service).to have_received(:representative_info_by_address).with(address: fake_address)
      end

      it 'saves response to Reps model' do
        expect(Representative).to have_received(:civic_api_to_representative_params).with(fake_response)
      end

      it 'renders the search template' do
        expect(fake_response).to render_template('representatives/search')
      end
    end

    describe 'when address is empty' do
      before do
        get :search, params: { address: '' }
      end

      it 'returns to search page if address is null' do
        expect(fake_response).to render_template('representatives/index')
      end
    end
  end
end
