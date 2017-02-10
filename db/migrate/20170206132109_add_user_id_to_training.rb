class AddTrainerIdToTraining < ActiveRecord::Migration[5.0]
  def change
    add_column :trainings, :trainer_id, :integer
  end
end
