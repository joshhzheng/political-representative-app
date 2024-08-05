# frozen_string_literal: true

class MoreRepresentativeInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :address, :string
    add_column :representatives, :party, :string
    add_column :representatives, :photo, :string
  end
end
