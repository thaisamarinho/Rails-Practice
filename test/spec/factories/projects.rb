FactoryGirl.define do
  factory :project do
    sequence(:title) {|n| "Hello World #{n}"}
    description {Faker::Hipster.paragraph}
    due_date {Faker::Date.forward(365)}
  end
end
