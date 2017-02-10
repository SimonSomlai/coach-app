class CustomExercise < Exercise
  # STI -> Adds type "CustomExercise" to Exercise table
  belongs_to :trainer
end
