# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    address = params[:address]

    if address.blank?
      # TODO: next line needs to be uncommented to log out after pull
      # fix this!
      # session[:current_user_id] = nil
      render 'representatives/index'
      return
    end

    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]

    begin
      result = service.representative_info_by_address(address: address)
    rescue Google::Apis::ClientError => e
      if e.status_code == 400
        render 'representatives/index'
        return
      end
    end

    @representatives = Representative.civic_api_to_representative_params(result)
    render 'representatives/search'
  end
end
