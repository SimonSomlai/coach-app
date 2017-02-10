class AddRemoteImagesToExercise < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :remote_images, :text
  end
end
