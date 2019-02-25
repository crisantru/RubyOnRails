require 'test_helper'

class ArticlesOrdersControllerTest < ActionController::TestCase
  setup do
    @articles_order = articles_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create articles_order" do
    assert_difference('ArticlesOrder.count') do
      post :create, articles_order: {  }
    end

    assert_redirected_to articles_order_path(assigns(:articles_order))
  end

  test "should show articles_order" do
    get :show, id: @articles_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @articles_order
    assert_response :success
  end

  test "should update articles_order" do
    patch :update, id: @articles_order, articles_order: {  }
    assert_redirected_to articles_order_path(assigns(:articles_order))
  end

  test "should destroy articles_order" do
    assert_difference('ArticlesOrder.count', -1) do
      delete :destroy, id: @articles_order
    end

    assert_redirected_to articles_orders_path
  end
end
