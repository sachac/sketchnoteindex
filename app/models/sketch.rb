class Sketch < ActiveRecord::Base
  attr_accessible :artist_id, :topic_id, :upload_date, :url, :topic, :artist
  validates :url, :presence => true
  belongs_to :topic
  belongs_to :artist
  def self.process(data)
    # Look up the collection as needed
    topic = Topic.get_or_create(data[:topic], data[:collection]) if data[:topic]
    artist = Artist.get_or_create(data[:artist]) if data[:artist]
    Sketch.create(url: data[:url], topic: topic, artist: artist, upload_date: data[:upload_date])
  end
  delegate :collection, :to => :topic
end
