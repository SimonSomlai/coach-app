require 'test_helper'

class ExerciseImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_image = exercise_images(:one)
  end

  test "should get index" do
    get exercise_images_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_image_url
    assert_response :success
  end

  test "should create exercise_image" do
    assert_difference('ExerciseImage.count') do
      post exercise_images_url, params: { exercise_image: { exercise_id: @exercise_image.exercise_id, image: @exercise_image.image } }
    end

    assert_redirected_to exercise_image_url(ExerciseImage.last)
  end

  test "should show exercise_image" do
    get exercise_image_url(@exercise_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_image_url(@exercise_image)
    assert_response :success
  end

  test "should update exercise_image" do
    patch exercise_image_url(@exercise_image), params: { exercise_image: { exercise_id: @exercise_image.exercise_id, image: @exercise_image.image } }
    assert_redirected_to exercise_image_url(@exercise_image)
  end

  test "should destroy exercise_image" do
    assert_difference('ExerciseImage.count', -1) do
      delete exercise_image_url(@exercise_image)
    end

    assert_redirected_to exercise_images_url
  end
end
