class Training < ApplicationRecord
 # Connects training to trainer_id
 belongs_to :trainer

 # Connects exercises to trainings with assigned_trainings join table - many to many.
 # Each exercise can belong to a different training and trainings can have different exercises
 # It's a bad name and I should have picked exercise_trainings :/. Sorry <(^.^)>
 has_many :assigned_trainings, dependent: :destroy
 has_many :exercises, through: :assigned_trainings

 # Image attachment for training
 mount_uploader :image, ImageUploader

 # Connects a training with a cliënt using client_training join table  - many to many
 # Each training can belong to a different cliënt and cliënts can have different trainings
 has_many :client_trainings, dependent: :destroy
 has_many :clients, through: :client_trainings
end
