# Module that handles search parameters from users, for json and standard query
module ExercisesFinderHelper
  def find_exercises_for_trainer
    CustomExercise.includes(:exercise_images).where(trainer_id: current_user.id)
  end

  def find_exercises_for_client
    CustomExercise.includes(:exercise_images).where(trainer_id: current_user.trainer.id)
  end

  def filtered? # Request with a filter?
    !params[:button].nil?
  end

  def standard_included? # Are they requesting standard exercises?
    params[:standard_exercises].present? && params[:standard_exercises] != ""
  end

  def custom_included? # Are they requesting custom exercises?
    params[:custom_exercises].present? && params[:custom_exercises] != ""
  end

  def specific_focus? # Are they requesting a specific muscle group?
    params[:focus].present? && params[:focus] != "all"
  end

  def find_exercises # Retrieves accessible exercises for user type
    standard_exercises = GeneralExercise.all
    # Check user type and return CustomExercises accessible for that user
    custom_exercises = current_user.type == 'Trainer' ? find_exercises_for_trainer : find_exercises_for_client
    if filtered? # are they requesting a filtered view?
      standard_exercises = standard_included? ? filter_exercises(standard_exercises) : []
      custom_exercises = custom_included?  ? filter_exercises(custom_exercises) : []
    end
    exercises = custom_exercises + standard_exercises
    exercises.sort!{|a,b| a.title <=> b.title } unless exercises.blank? # Sort alphabetically, skip if empty
    exercises
  end

  def filter_exercises(exercises) # Filters exercises by params
    exercises = exercises.where(["lower(title) LIKE ?","%#{params[:name]}%"]) if params[:name].present?
    exercises = exercises.where(["lower(focus) LIKE ?","%#{params[:focus]}%"]) if specific_focus?
    exercises
  end
end
