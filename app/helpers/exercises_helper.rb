# frozen_string_literal: true
module ExercisesHelper
  include ExercisesFinderHelper
  def limit_altering_permission # Don't allow trainers to modify the general exercises
    if !current_user.admin? && @exercise.type == 'GeneralExercise'
      redirect_to exercises_path
      flash[:success] = 'Trainers kunnen geen standaard oefeningen bewerken of verwijderen'
    end
  end

  def parse_youtube(url) # returns video id for iframe embed
    regex = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/
    url.match(regex)[1]
  end

  def limit_viewing_permission # Don't allow trainers to access custom exercises made by other trainers
    if current_user_is_trainer?
      if !@exercise.trainer_id.nil? && @exercise.trainer_id != current_user.id
        redirect_to exercises_path
        flash[:danger] = 'Dat is geen oefening van jou :/'
      end
    end
  end

  def get_first_image(exercise) # Get first image belonging to training
    if exercise.exercise_images.try(:first)
      @header_image = exercise.exercise_images.first.image_url
    else
       if exercise.remote_images.blank?
      @header_image = 'placeholder.png'
      else
        @header_image = exercise.remote_images.split(',')[0]
      end
   end
  end
end
