require 'test_helper'

class ShipmentsArticlesControllerTest < ActionController::TestCase
  setup do
    @shipments_article = shipments_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipments_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipments_article" do
    assert_difference('ShipmentsArticle.count') do
      post :create, shipments_article: {  }
    end

    assert_redirected_to shipments_article_path(assigns(:shipments_article))
  end

  test "should show shipments_article" do
    get :show, id: @shipments_article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipments_article
    assert_response :success
  end

  test "should update shipments_article" do
    patch :update, id: @shipments_article, shipments_article: {  }
    assert_redirected_to shipments_article_path(assigns(:shipments_article))
  end

  test "should destroy shipments_article" do
    assert_difference('ShipmentsArticle.count', -1) do
      delete :destroy, id: @shipments_article
    end

    assert_redirected_to shipments_articles_path
  end
end
