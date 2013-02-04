class Collection < ActiveRecord::Base
  attr_accessible :date_string, :location, :name, :start_date
  has_many :topics
  def self.get_or_create(search)
    if search.is_a? Collection then return search end
    Ambiguity.handle(Collection.where(name: search), :collection) do
      Collection.create(name: search)
    end
  end
end
