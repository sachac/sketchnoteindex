class Sketch < ActiveRecord::Base
  attr_accessible :artist_id, :topic_id, :upload_date, :url, :topic, :artist
  validates :url, :presence => true
  belongs_to :topic
  belongs_to :artist
  def self.process(data)
    # Look up the collection as needed
    puts data.inspect
    if data[:topic]
      topic = Topic.get_or_create(data[:topic], data[:collection])
      if data[:people] and topic.people.blank?
        topic.people = data[:people]
        topic.save
      end
    end
    artist = Artist.get_or_create(data[:artist]) if data[:artist]
    Sketch.create(url: data[:url], topic: topic, artist: artist, upload_date: data[:upload_date])
  end


  def self.parse_flickr(data, collection)
    doc = Nokogiri::HTML(data)
    # Identify the artist for this page
    url = doc.xpath('//link[@rel="canonical"]').first["href"]
    artist = Artist.guess_by_url(url)
    topic = nil
    upload_date = nil
    # Set the artist's name if not yet set
    if artist.name == artist.flickr_username
      artist.name = doc.css(".username > a").first.content
      artist.save!
    end

    collection = Collection.get_or_create(collection)
    # Find the talk if possible
    title = doc.css("#title_div").first.content
    # Attempt to figure out the talk based on the talks seen so far
    topic_names = collection.topics.find(:all, :select => 'name').map(&:name)
    if topic_names.size == 0
      topic = Topic.get_or_create(title, collection)
    else
      matcher = Amatch::PairDistance.new(title)
      similarity_scores = matcher.match(topic_names)
      max = similarity_scores.max
      avg = similarity_scores.sum / similarity_scores.length
      stdev = similarity_scores.stdevp
      
      # We are confident if our maximum is two standard deviations away from the mean
      if (max - avg) >= 2 * stdev
        # Find the maximum
        index = similarity_scores.find_index(max)
        topic = Topic.get_or_create(topic_names[index], collection)
      else
        topic = Topic.get_or_create(title, collection)
      end
    end
    upload_date = Chronic.parse(doc.css("#photo-story-story > a").first.content)
    # # Now we have artist, title, and collection
    Sketch.create(url: url, topic: topic, artist: artist, upload_date: upload_date)
  end
  delegate :collection, :to => :topic, :allow_nil => true
  delegate :people, :to => :topic, :allow_nil => true

  comma do
    created_at 
    collection :name => 'Collection'
    topic :name => 'Topic'
    topic :people
    artist :name => 'Artist'
    upload_date
    url
  end
end
