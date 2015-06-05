require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { baby_age: @user.baby_age, baby_name: @user.baby_name, email: @user.email, image_url: @user.image_url, name: @user.name, password: @user.password }
    end

    assert_response 201
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { baby_age: @user.baby_age, baby_name: @user.baby_name, email: @user.email, image_url: @user.image_url, name: @user.name, password: @user.password }
    assert_response 204
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_response 204
  end
end
