class AddFlickrUsernameToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :flickr_username, :string
  end
end
