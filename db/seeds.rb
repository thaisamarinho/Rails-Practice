


10.times do
  Tag.create(name: Faker::GameOfThrones.house)
end

tags = Tag.all

100.times do
  Question.create({ title: Faker::Company.catch_phrase,
                    body:  Faker::Hacker.say_something_smart,
                    tags:  tags.sample(rand(3) + 1),
                    view_count: rand(1000) })
end
