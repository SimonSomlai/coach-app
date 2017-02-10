class ExerciseImagesController < ApplicationController
  before_action :set_exercise_image, only: [:show, :edit, :update, :destroy]
  before_action :limit_client_access, except: [:index, :show]
  before_filter :logged_in_user?


  # GET /exercise_images
  # GET /exercise_images.json
  def index
    @exercise_images = ExerciseImage.all
  end

  # GET /exercise_images/1
  # GET /exercise_images/1.json
  def show
  end

  # GET /exercise_images/new
  def new
    @exercise_image = ExerciseImage.new
  end

  # GET /exercise_images/1/edit
  def edit
  end

  # POST /exercise_images
  # POST /exercise_images.json
  def create
    @exercise_image = ExerciseImage.new(exercise_image_params)

    respond_to do |format|
      if @exercise_image.save
        format.html { redirect_to @exercise_image, notice: 'Exercise image was successfully created.' }
        format.json { render :show, status: :created, location: @exercise_image }
      else
        format.html { render :new }
        format.json { render json: @exercise_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercise_images/1
  # PATCH/PUT /exercise_images/1.json
  def update
    respond_to do |format|
      if @exercise_image.update(exercise_image_params)
        format.html { redirect_to @exercise_image, notice: 'Exercise image was successfully updated.' }
        format.json { render :show, status: :ok, location: @exercise_image }
      else
        format.html { render :edit }
        format.json { render json: @exercise_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercise_images/1
  # DELETE /exercise_images/1.json
  def destroy
    @exercise_image.destroy
    respond_to do |format|
      format.html { redirect_to exercise_images_url, notice: 'Exercise image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_image
      @exercise_image = ExerciseImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_image_params
      params.require(:exercise_image).permit(:exercise_id, :image)
    end
end
