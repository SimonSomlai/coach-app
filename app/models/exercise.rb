class Exercise < ApplicationRecord
  # Seperate table for multiple image attachments for an exercise
  has_many :exercise_images, dependent: :destroy
  accepts_nested_attributes_for :exercise_images

  # Connects exercises to trainings with assigned_trainings join table - many to many.
  # Each exercise can belong to a different training and trainings can have different exercises
  has_many :assigned_trainings, dependent: :destroy
  has_many :trainings, through: :assigned_trainings

  # Validations
  validates :title, :description, :focus, :exercise_type, presence: true
end
