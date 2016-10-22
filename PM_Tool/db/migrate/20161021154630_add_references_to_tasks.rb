class AddReferencesToTasks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :project, foreign_key: true, index: true
  end
end
