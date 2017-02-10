class AddTrainerIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :trainer_id, :integer
  end
end
