FactoryGirl.define do
  factory :topic do
    collection
    sequence(:name) { |n| "Example topic #{n} "}
    people "Person A, Person B"
  end
end
