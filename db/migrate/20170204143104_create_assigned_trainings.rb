class CreateAssignedTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :assigned_trainings do |t|
      t.integer :exercise_id
      t.integer :training_id
      t.timestamps
    end
  end
end
