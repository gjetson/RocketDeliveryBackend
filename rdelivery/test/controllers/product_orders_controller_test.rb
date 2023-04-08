require "test_helper"

class ProductOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_order = product_orders(:one)
  end

  test "should get index" do
    get product_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_product_order_url
    assert_response :success
  end

  test "should create product_order" do
    assert_difference("ProductOrder.count") do
      post product_orders_url, params: { product_order: { order_id: @product_order.order_id, product_id: @product_order.product_id, product_quantity: @product_order.product_quantity, product_unit_cost: @product_order.product_unit_cost } }
    end

    assert_redirected_to product_order_url(ProductOrder.last)
  end

  test "should show product_order" do
    get product_order_url(@product_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_order_url(@product_order)
    assert_response :success
  end

  test "should update product_order" do
    patch product_order_url(@product_order), params: { product_order: { order_id: @product_order.order_id, product_id: @product_order.product_id, product_quantity: @product_order.product_quantity, product_unit_cost: @product_order.product_unit_cost } }
    assert_redirected_to product_order_url(@product_order)
  end

  test "should destroy product_order" do
    assert_difference("ProductOrder.count", -1) do
      delete product_order_url(@product_order)
    end

    assert_redirected_to product_orders_url
  end
end
