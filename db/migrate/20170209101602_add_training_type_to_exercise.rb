class AddTrainingTypeToExercise < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :training_type, :string, index: true
  end
end
