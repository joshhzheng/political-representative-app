class AddDetailsToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :contact_address, :string
    add_column :representatives, :contact_city, :string
    add_column :representatives, :contact_state, :string
    add_column :representatives, :contact_zip, :string
    add_column :representatives, :political_party, :string
    add_column :representatives, :photo_url, :string
  end
end
