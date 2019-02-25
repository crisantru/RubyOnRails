require 'test_helper'

class StaffTypesControllerTest < ActionController::TestCase
  setup do
    @staff_type = staff_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staff_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff_type" do
    assert_difference('StaffType.count') do
      post :create, staff_type: {  }
    end

    assert_redirected_to staff_type_path(assigns(:staff_type))
  end

  test "should show staff_type" do
    get :show, id: @staff_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @staff_type
    assert_response :success
  end

  test "should update staff_type" do
    patch :update, id: @staff_type, staff_type: {  }
    assert_redirected_to staff_type_path(assigns(:staff_type))
  end

  test "should destroy staff_type" do
    assert_difference('StaffType.count', -1) do
      delete :destroy, id: @staff_type
    end

    assert_redirected_to staff_types_path
  end
end
