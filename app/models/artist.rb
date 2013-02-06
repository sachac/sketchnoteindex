class Artist < ActiveRecord::Base
  attr_accessible :image_url, :name, :url, :flickr_username
  has_many :sketches
  def self.get_or_create(search)
    if search.is_a? Artist then return search end
    Ambiguity.handle(Artist.where(name: search), :artist) do
      Artist.create(name: search)
    end
  end

  def self.guess_by_url(search)
    if search =~ %r{flickr.com/photos/([^/]+)}
      username = Regexp.last_match(1)
      list = Artist.where(flickr_username: username)
      Ambiguity.handle(list, :flickr_username) do
        Artist.create(name: username, flickr_username: username)
      end
    end
  end
end
