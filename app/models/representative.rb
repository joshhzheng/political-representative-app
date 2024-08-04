# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      address_temp = ''
      city_temp = ''
      state_temp = ''
      zip_temp = ''
      party_temp = official.party || ''
      photo_temp = official.photoUrl || ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
          if official.address.present?
            address = official.address.first
            address_temp = address.line1
            city_temp = address.city
            state_temp = address.state
            zip_temp = address.zip
          end
        end
      end

      rep = Representative.create!({
        name: official.name,
        ocdid: ocdid_temp,
        title: title_temp,
        contact_address: address_temp,
        contact_city: city_temp,
        contact_state: state_temp,
        contact_zip: zip_temp,
        political_party: party_temp,
        photo_url: photo_temp
      })
      reps.push(rep)
    end

    reps
  end
end
