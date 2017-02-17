require 'test_helper'

class UserServiceCategoriesControllerTest < ActionController::TestCase
  setup do
    @user_service_category = user_service_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_service_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_service_category" do
    assert_difference('UserServiceCategory.count') do
      post :create, user_service_category: { description: @user_service_category.description, hourly_rate: @user_service_category.hourly_rate, service_category_id: @user_service_category.service_category_id, user_id: @user_service_category.user_id }
    end

    assert_redirected_to user_service_category_path(assigns(:user_service_category))
  end

  test "should show user_service_category" do
    get :show, id: @user_service_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_service_category
    assert_response :success
  end

  test "should update user_service_category" do
    patch :update, id: @user_service_category, user_service_category: { description: @user_service_category.description, hourly_rate: @user_service_category.hourly_rate, service_category_id: @user_service_category.service_category_id, user_id: @user_service_category.user_id }
    assert_redirected_to user_service_category_path(assigns(:user_service_category))
  end

  test "should destroy user_service_category" do
    assert_difference('UserServiceCategory.count', -1) do
      delete :destroy, id: @user_service_category
    end

    assert_redirected_to user_service_categories_path
  end
end
