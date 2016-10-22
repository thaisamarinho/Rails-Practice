200.times do
  Project.create({ title: Faker::Company.catch_phrase,
                    description: Faker::Lorem.paragraph,
                    due_date: Faker::Date.forward(365)})
end
