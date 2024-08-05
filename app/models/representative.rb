# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    raise ArgumentError, 'Invalid representative input.' if rep_info.blank?

    reps = []
    rep_info.officials.each_with_index do |official, index|
      title_temp = ''
      ocdid_temp = ''
      address_temp = get_address(official)

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep = Representative.find_or_create_by!(name: official.name, ocdid: ocdid_temp, title: title_temp,
                                              address: address_temp, party: official.party || '',
                                              photo: official.photo_url || '')
      reps.push(rep)
    end

    reps
  end

  def self.get_address(official)
    return '' if official.address.blank?

    address = official.address.first
    "#{address.line1} #{address.line2} #{address.line3} #{address.city} #{address.state} #{address.zip}"
  end
end
