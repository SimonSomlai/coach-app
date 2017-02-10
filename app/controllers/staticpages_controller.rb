class StaticpagesController < ApplicationController
  before_filter :logged_in_user?, except: [:home]
  before_action :limit_client_access, except: [:client_dashboard, :home]

  def dashboard
      @trainer_exercises = CustomExercise.where(trainer_id: current_user.id).size + GeneralExercise.all.size
  end

  def client_dashboard
    @client = current_user
    @trainings = ClientTraining.where(client_id: @client)
  end

  def home

  end
end
