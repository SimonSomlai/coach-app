module TrainingsHelper
  require "json"
  def current_exercises(training) # Loads exercises into select2 box on training edit
    data = []
    training.exercises.order("position ASC").each_with_index do |exercise, i|
      data << { id: "exercise-#{exercise.id}", text: exercise.title, selected: "selected" }
    end
    data
  end

  def find_exercises_for_training(training)
    training.exercises.order("title ASC").collect(&:title).join(", ")
  end
end
