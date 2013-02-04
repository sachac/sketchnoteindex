class AddArtistCountToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :artist_count, :integer
  end
end
