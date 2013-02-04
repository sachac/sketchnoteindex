class Artist < ActiveRecord::Base
  attr_accessible :image_url, :name, :url
  has_many :sketches
  def self.get_or_create(search)
    if search.is_a? Artist then return search end
    Ambiguity.handle(Artist.where(name: search), :artist) do
      Artist.create(name: search)
    end
  end
end
