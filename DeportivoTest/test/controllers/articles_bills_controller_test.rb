require 'test_helper'

class ArticlesBillsControllerTest < ActionController::TestCase
  setup do
    @articles_bill = articles_bills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles_bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create articles_bill" do
    assert_difference('ArticlesBill.count') do
      post :create, articles_bill: {  }
    end

    assert_redirected_to articles_bill_path(assigns(:articles_bill))
  end

  test "should show articles_bill" do
    get :show, id: @articles_bill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @articles_bill
    assert_response :success
  end

  test "should update articles_bill" do
    patch :update, id: @articles_bill, articles_bill: {  }
    assert_redirected_to articles_bill_path(assigns(:articles_bill))
  end

  test "should destroy articles_bill" do
    assert_difference('ArticlesBill.count', -1) do
      delete :destroy, id: @articles_bill
    end

    assert_redirected_to articles_bills_path
  end
end
