class CreateClientTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :client_trainings do |t|
      t.integer :training_id
      t.integer :client_id
      t.datetime :date
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
