FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "Artist number #{n}" }
    image_url "http://example.com/image.png"
    url "http://example.com"
    flickr_username { |n| "flickr#{n}" } 
  end
end
