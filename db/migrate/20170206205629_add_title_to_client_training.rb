class AddTitleToClientTraining < ActiveRecord::Migration[5.0]
  def change
    add_column :client_trainings, :title, :string
  end
end
