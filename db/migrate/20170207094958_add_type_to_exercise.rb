class AddTypeToExercise < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :type, :string
    add_reference :exercises, :trainer, index: true
  end
end
