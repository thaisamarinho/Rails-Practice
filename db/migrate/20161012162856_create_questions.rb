class CreateQuestions < ActiveRecord::Migration[5.0]

  # Some times this kind of code is called DSL: Domain Specific Language
  # It's still ruby code but written in a way that seems like a new language
  # Ruby is flexible to allow that

  # This migration file is not the database or the database table. It's
   # a list of instructions to generate the SQL to create the table in the
   # database
  def change
    # by default Rails will always create a primary key integer: id
    create_table :questions do |t|
      t.string :title
      t.text :body

      # this generate two timestamp columns: created_at & updated_at
      t.timestamps
    end
  end
end
