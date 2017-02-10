# frozen_string_literal: true
class TrainingsController < ApplicationController
 require 'will_paginate/array'
 include TrainingsHelper
 include ExercisesHelper
 before_action :set_trainings, only: [:index,:update,:create, :edit]
 before_action :find_training, except: [:index, :create, :assign_training, :remove_training, :complete_training]
 before_action :limit_client_access, except: [:show, :complete_training]
 before_filter :logged_in_user?

 # ----------------------- CRUD ACTIONS ----------------------------------------------

 def index
  @action = 'Nieuwe'
  @training = Training.new
  # Show accessible exercises - the ones already in the training
  @exercises = find_exercises - @training.exercises
end

 def show
  @training_exercises = @training.exercises.includes(:exercise_images).order("position ASC")
  # Get material from each exercise belonging to training, strip empties & remove doubles.
  @material = @training_exercises.map(&:equipment).reject(&:blank?).uniq!.join(', ')
  @count = @training_exercises.count
 end

 def create
  @training = current_user.trainings.build(training_params)
  if @training.save
   params[:exercises].each_with_index do |exercise, position|
    AssignedTraining.create!(exercise_id: exercise, training_id: @training.id, position: position + 1)
   end
   flash[:success] = "#{@training.title} aangemaakt"
   redirect_to trainings_path
  else
   render :index
   flash[:danger] = 'An error occured'
  end
 end

 def edit
  @exercises = find_exercises - @training.exercises
  @action = 'Bewerk'
  render :index
 end

 def update
  @training.exercises.destroy_all # There's probably a better way (like checking for differences)
  if @training.update_attributes(training_params)
   params[:exercises].each_with_index do |exercise_id, position|
    exercise_id = exercise_id.gsub('exercise-', '').to_i
    AssignedTraining.create!(training_id: @training.id, exercise_id: exercise_id, position: position + 1)
   end
   flash[:success] = "#{@training.title}'s bewerkt!"
   redirect_to trainings_path
  else
   @action = 'Bewerk'
   flash[:danger] = 'Er was een error.'
   render :index
  end
 end

 def destroy
  title = @training.title
  @training.destroy
  redirect_to trainings_path
  flash[:success] = "#{title} verwijderd!"
 end

 # ----------------------- ASSIGNING & REMOVING TRAININGS TO CLIENTS ----------------------------------------------

 def assign_training # Allows trainer to add ClientTraining from client
  title = Training.find(params[:training_id]).title
  ClientTraining.create!(date: params[:client_training][:date], title: title, training_id: params[:training_id], client_id: params[:client_training][:client_id])
  redirect_to user_client_path(user_id: current_user.id, id: params[:client_training][:client_id].to_i)
 end

 def remove_training  # Allows trainer to remove ClientTraining from client
  ClientTraining.find(params[:id]).destroy
  redirect_to user_client_path(user_id: current_user.id, id: params[:client_id].to_i)
 end

 def complete_training # Allows clients to change status of their ClientTraining to completed
  training = ClientTraining.find(params[:training_id])
  training.status = true
  training.save!
  redirect_to client_dashboard_path
 end

 # ----------------------- PRIVATE ----------------------------------------------
 private

 def training_params
  params.require(:training).permit(:title, :description, :time, :level, :exercises, :image)
 end

 def find_training
  @training = Training.find(params[:id])
 end

 def set_trainings
   @trainings = current_user.trainings.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 12)
 end
end
