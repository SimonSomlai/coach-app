class ExerciseImage < ApplicationRecord
  # Exercises have many exercise_images  
  mount_uploader :image, ImageUploader
  belongs_to :exercise, dependent: :destroy
end
