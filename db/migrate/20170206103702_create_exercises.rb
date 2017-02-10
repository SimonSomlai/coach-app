class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.string :title
      t.text :description
      t.string :video
      t.string :equipment
    end
  end
end
