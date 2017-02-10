class AddPositionToAssignedTrainings < ActiveRecord::Migration[5.0]
  def change
    add_column :assigned_trainings, :position, :integer
  end
end
