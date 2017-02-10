class AddImageToTraining < ActiveRecord::Migration[5.0]
  def change
    add_column :training, :image, :string
  end
end
