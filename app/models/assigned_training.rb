class AssignedTraining < ApplicationRecord
  # Join Table (trainings & exercises)
  belongs_to :training
  belongs_to :exercise
end
