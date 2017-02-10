class AddFocusToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :focus, :string
  end
end
