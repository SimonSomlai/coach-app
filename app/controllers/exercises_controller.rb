# frozen_string_literal: true
class ExercisesController < ApplicationController
  require 'will_paginate/array'
  include ExercisesHelper
  before_action :find_exercise, except: [:index, :create, :remove]
  before_action :set_exercises, only: [:index, :create, :update, :edit]
  before_action :limit_altering_permission, only: [:destroy, :edit, :update]
  before_action :limit_viewing_permission, only: [:show]
  before_action :limit_client_access, except: [:index, :show]
  before_filter :logged_in_user?

  def index
    @url = exercises_path
    @action = 'Nieuwe'
    @exercise = CustomExercise.new
    @exercise_images = @exercise.exercise_images.build
    respond_to do |format|
      format.html
      format.json { render json: @exercises + @images }
    end
  end

  def show
    @youtube = @exercise.video.include?('youtube') ? true : false
    @exercise_video = @exercise.video
    unless @exercise_video.include?('http://')
      @exercise_video = 'http://' + @exercise_video
    end
    @exercise_images = @exercise.exercise_images.all
    @remote_images = @exercise.remote_images.blank? ? [] : @exercise.remote_images.split(',')
  end

  def create
    @exercise = current_user.custom_exercises.build(custom_exercise_params)
    if @exercise.save
      unless params[:exercise_images].nil?
        params[:exercise_images][:image].each do |image|
          @exercise_image = @exercise.exercise_images.create!(image: image)
        end
      end
      flash[:success] = "#{@exercise.title} aangemaakt"
      redirect_to exercise_path(@exercise)
    else
      @url = exercises_path
      @action = "Bewerk"
      render :index
      flash[:danger] = 'Gelieve alle verplichte velden in te vullen'
    end
  end

  def edit
    @url = exercise_path(@exercise)
    @action = 'Bewerk'
    render :index
  end

  def update
    @exercise.type == 'GeneralExercise' ? (exercise_params = general_exercise_params) : (exercise_params = custom_exercise_params)
    if @exercise.update_attributes(exercise_params)
      unless params[:exercise_images].nil?
        @exercise.exercise_images.destroy_all
        params[:exercise_images][:image].each do |image|
          @exercise_image = @exercise.exercise_images.create!(image: image)
        end
      end
      flash[:success] = "#{@exercise.title} bewerkt!"
      redirect_to exercise_path(@exercise)
    else
      @action = 'Bewerk'
      flash[:danger] = 'Er is een fout opgetreden'
      @url = exercises_path
      render :index
    end
  end

  def destroy
    title = @exercise.title
    @exercise.destroy
    redirect_to exercises_path
    flash[:success] = "#{title} verwijderd!"
  end

  # Removes exercise from formed trainings
  def remove
    training = params[:training_id]
    AssignedTraining.find_by(exercise_id: params[:exercise_id], training_id: params[:training_id]).delete
    flash[:success] = 'Oefening verwijderd van training!'
    redirect_to training_path(training)
  end

  private

  def general_exercise_params
    params.require(:general_exercise).permit(:title, :description, :type, :video,:focus, :exercise_type, :trainer_id, :equipment, exercise_images_attributes: [:id, :exercise_id, :image])
  end

  def custom_exercise_params
    params.require(:custom_exercise).permit(:title, :description, :type, :video, :trainer_id, :focus, :exercise_type,:equipment, exercise_images_attributes: [:id, :exercise_id, :image])
  end

  def find_exercise
    @exercise = Exercise.includes(:exercise_images).find(params[:id])
  end

  def set_exercises
    if params[:ajax].present?
      @exercises = find_exercises[0..49]
      @images = @exercises.collect{|ex| ex.exercise_images[0].try(:image_url) }
    else
      @exercises = find_exercises.paginate(page: params[:page], per_page: 12)
    end
  end
end
