class AddIndexesToDatabaseTables < ActiveRecord::Migration[5.0]
  def change
    add_index(:assigned_trainings, :exercise_id)
    add_index(:assigned_trainings, :training_id)
    add_index(:assigned_trainings, :position)

    add_index(:client_trainings, :client_id)
    add_index(:client_trainings, :training_id)

    add_index(:exercise_images, :exercise_id)

    add_index(:exercises, :equipment)

    add_index(:trainings, :trainer_id)

    add_index(:users, :admin)
    add_index(:users, :trainer_id)
    add_index(:users, :type)
  end
end
