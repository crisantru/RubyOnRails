require 'test_helper'

class SalesArticlesControllerTest < ActionController::TestCase
  setup do
    @sales_article = sales_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sales_article" do
    assert_difference('SalesArticle.count') do
      post :create, sales_article: {  }
    end

    assert_redirected_to sales_article_path(assigns(:sales_article))
  end

  test "should show sales_article" do
    get :show, id: @sales_article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sales_article
    assert_response :success
  end

  test "should update sales_article" do
    patch :update, id: @sales_article, sales_article: {  }
    assert_redirected_to sales_article_path(assigns(:sales_article))
  end

  test "should destroy sales_article" do
    assert_difference('SalesArticle.count', -1) do
      delete :destroy, id: @sales_article
    end

    assert_redirected_to sales_articles_path
  end
end
