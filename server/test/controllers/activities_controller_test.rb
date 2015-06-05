require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  setup do
    @activity = activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activities)
  end

  test "should create activity" do
    assert_difference('Activity.count') do
      post :create, activity: { created_time: @activity.created_time, description: @activity.description, image_url: @activity.image_url, location_latitude: @activity.location_latitude, location_longitude: @activity.location_longitude, max_number: @activity.max_number, name: @activity.name, start_time: @activity.start_time, updated_time: @activity.updated_time }
    end

    assert_response 201
  end

  test "should show activity" do
    get :show, id: @activity
    assert_response :success
  end

  test "should update activity" do
    put :update, id: @activity, activity: { created_time: @activity.created_time, description: @activity.description, image_url: @activity.image_url, location_latitude: @activity.location_latitude, location_longitude: @activity.location_longitude, max_number: @activity.max_number, name: @activity.name, start_time: @activity.start_time, updated_time: @activity.updated_time }
    assert_response 204
  end

  test "should destroy activity" do
    assert_difference('Activity.count', -1) do
      delete :destroy, id: @activity
    end

    assert_response 204
  end
end
