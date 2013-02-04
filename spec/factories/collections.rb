FactoryGirl.define do
  factory :collection do 
    sequence(:name) { |n| "Collection #{n}" }
    sequence(:start_date) { |n| Date.new(2013, 1, n) }
    date_string { start_date.to_s }
    location "Somewhere"
  end
end
