class CreateTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :trainings do |t|
      t.string :title
      t.text :description
      t.string :time
      t.integer :level

      t.timestamps
    end
  end
end
