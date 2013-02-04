class Sketch < ActiveRecord::Base
  attr_accessible :artist_id, :topic_id, :upload_date, :url
end
