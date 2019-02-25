require 'test_helper'

class InventoriesStocksControllerTest < ActionController::TestCase
  setup do
    @inventories_stock = inventories_stocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventories_stocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventories_stock" do
    assert_difference('InventoriesStock.count') do
      post :create, inventories_stock: {  }
    end

    assert_redirected_to inventories_stock_path(assigns(:inventories_stock))
  end

  test "should show inventories_stock" do
    get :show, id: @inventories_stock
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventories_stock
    assert_response :success
  end

  test "should update inventories_stock" do
    patch :update, id: @inventories_stock, inventories_stock: {  }
    assert_redirected_to inventories_stock_path(assigns(:inventories_stock))
  end

  test "should destroy inventories_stock" do
    assert_difference('InventoriesStock.count', -1) do
      delete :destroy, id: @inventories_stock
    end

    assert_redirected_to inventories_stocks_path
  end
end
