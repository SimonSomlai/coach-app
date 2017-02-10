class AddIndexToExerciseTypeInExercisesTable < ActiveRecord::Migration[5.0]
  def change
    add_index :exercises, :exercise_type
  end
end
