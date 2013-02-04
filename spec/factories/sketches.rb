FactoryGirl.define do
  factory :sketch do
    topic
    artist
    sequence(:url) { |n| "http://example.com/#{n}.png"}
    upload_date { Time.now }
  end
end
