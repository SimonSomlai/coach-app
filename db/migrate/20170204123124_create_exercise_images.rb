class CreateExerciseImages < ActiveRecord::Migration[5.0]
  def change
    create_table :exercise_images do |t|
      t.integer :exercise_id
      t.string :image

      t.timestamps
    end
  end
end
