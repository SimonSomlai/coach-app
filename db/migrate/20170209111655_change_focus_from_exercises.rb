class ChangeFocusFromExercises < ActiveRecord::Migration[5.0]
  def change
    rename_column :exercises, :training_type, :exercise_type, index: true
  end
end
