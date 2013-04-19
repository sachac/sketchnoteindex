class Topic < ActiveRecord::Base
  attr_accessible :collection_id, :name, :people, :collection
  belongs_to :collection
  has_many :sketches
  
  def self.get_or_create(search, collection = nil)
    search = '' if search.blank?
    collection ||= ''
    if search.is_a? Topic then return search end
    if collection.blank? or collection == ""
      return Ambiguity.handle(Topic.where(name: search), :topic) do
        Topic.create(name: search)
      end
    end
    # There is a collection. Is it an object?
    collection = Collection.get_or_create(collection) if collection.is_a? String and !collection.blank?
    if collection.is_a? Collection
      list = collection.topics.where(name: search)
      Ambiguity.handle(collection.topics.where(name: search), :topic) do
        Topic.create(name: search, collection: collection)
      end
    end
  end
end
