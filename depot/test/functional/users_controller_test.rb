require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @input_attributes = {
        name: "sam",
        current_password:"secret",
        password: "private",
        password_confirmation: "private"}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @input_attributes
    end

    assert_redirected_to users_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user if current_password correct" do
    put :update, id: @user, user: @input_attributes
    assert_redirected_to users_path
  end

  test "shouldn't update user if current_password wrong" do
    @input_attributes[:current_password] = "wrong"
    put :update, id: @user, user: @input_attributes
    assert_redirected_to edit_user_path @user
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
