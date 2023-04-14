class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    user = User.create!(name: "User 1", email: "test@test.com", password: "password")
    address = Address.create!(street_address: "Street 1", city: "City 1", postal_code: "11111")
    restaurant = Restaurant.create!(user: user, address: address, name: "Restaurant 1", phone: "123456", price_range: 2)
    customer = Customer.create!(user: user, address: address, phone: "123456")
    product = Product.create!(name: "Product 1", cost: 10, restaurant: restaurant)
    order_status = OrderStatus.create(name: "pending")
    OrderStatus.create(name: "in progress")
    OrderStatus.create(name: "delivered")
    @order = Order.create!(restaurant: restaurant, customer: customer, order_status: order_status, restaurant_rating: 4)
  end

  test "orders route exists and is a GET route" do
    assert_routing({ path: '/api/orders', method: :get }, { controller: 'api/orders', action: 'index' })
  end

  test "update order status to 'pending'" do
    post "/api/order/#{@order.id}/status", params: { status: "pending" }
    assert_response :success
    assert_equal "pending", @order.reload.order_status.name
  end

  test "update order status to 'in progress'" do
    post "/api/order/#{@order.id}/status", params: { status: "in progress" }
    assert_response :success
    assert_equal "in progress", @order.reload.order_status.name
  end

  test "update order status to 'delivered'" do
    post "/api/order/#{@order.id}/status", params: { status: "delivered" }
    assert_response :success
    assert_equal "delivered", @order.reload.order_status.name
  end

  test "return 422 error for invalid status" do
    post "/api/order/#{@order.id}/status", params: { status: "invalid" }
    assert_response 422
  end

  test "return 422 error for invalid order" do
    post "/api/order/0/status", params: { status: "pending" }
    assert_response 422
  end

  test "get orders with type = 'customer'" do
    user = User.create!(name: "User 2", email: "test2@test.com", password: "password")
    address = Address.create!(street_address: "Street 2", city: "City 2", postal_code: "11112")
    restaurant = Restaurant.create!(user: user, address: address, name: "Restaurant 2", phone: "123456", price_range: 2)
    customer = Customer.create!(user: user, address: address, phone: "123456")
    product = Product.create!(name: "Product 2", cost: 10, restaurant: restaurant)
    order_status = OrderStatus.create!(name: "Order Status 2")
    courier_status = CourierStatus.create!(name: "free")
    courier = Courier.create!(user: user, address: address, phone: "123456", email: "test3@test.com")
    order = Order.create!(restaurant: restaurant, customer: customer, order_status: order_status, restaurant_rating: 4, courier: courier)
    product_order = ProductOrder.create!(product: product, order: order, product_quantity: 2, product_unit_cost: 300)

    get "/api/orders", params: { type: "customer", user_id: customer.id}
    assert_response :ok
    assert_equal [
      {
        id: order.id, 
        customer_id: order.customer.id, 
        customer_name: order.customer.user.name, 
        customer_address: order.customer.address.street_address,
        restaurant_id: order.restaurant.id,
        restaurant_name: order.restaurant.name,
        restaurant_address: order.restaurant.address.street_address,
        courier_id: order.courier&.id,
        courier_name: order.courier&.user&.name,
        status: order.order_status.name,
        products: order.product_orders.map do |po|
        {
          product_id: po.product.id,
          product_name: po.product.name,
          product_quantity: po.product_quantity,
          unit_cost: po.product_unit_cost,
          total_cost: (po.product_quantity * po.product_unit_cost)
        }
        end,
        total_cost: order.total_cost
      }
    ].to_json, response.body
  end

  test "get orders with type = 'restaurant'" do
    user = User.create!(name: "User 3", email: "test3@test.com", password: "password")
    address = Address.create!(street_address: "Street 3", city: "City 3", postal_code: "11113")
    restaurant = Restaurant.create!(user: user, address: address, name: "Restaurant 3", phone: "123456", price_range: 2)
    customer = Customer.create!(user: user, address: address, phone: "123456")
    product = Product.create!(name: "Product 3", cost: 10, restaurant: restaurant)
    order_status = OrderStatus.create!(name: "Order Status 3")
    courier_status = CourierStatus.create!(name: "free")
    courier = Courier.create!(user: user, address: address, phone: "123456", email: "test3@test.com")
    order = Order.create!(restaurant: restaurant, customer: customer, order_status: order_status, restaurant_rating: 4, courier: courier)
    product_order = ProductOrder.create!(product: product, order: order, product_quantity: 2, product_unit_cost: 300)

    get "/api/orders", params: { type: "restaurant", user_id: restaurant.id}
    assert_response :ok
    assert_equal [
      {
        id: order.id, 
        customer_id: order.customer.id, 
        customer_name: order.customer.user.name, 
        customer_address: order.customer.address.street_address,
        restaurant_id: order.restaurant.id,
        restaurant_name: order.restaurant.name,
        restaurant_address: order.restaurant.address.street_address,
        courier_id: order.courier&.id,
        courier_name: order.courier&.user&.name,
        status: order.order_status.name,
        products: order.product_orders.map do |po|
        {
          product_id: po.product.id,
          product_name: po.product.name,
          product_quantity: po.product_quantity,
          unit_cost: po.product_unit_cost,
          total_cost: (po.product_quantity * po.product_unit_cost)
        }
        end,
        total_cost: order.total_cost
      }
    ].to_json, response.body
  end

  test "get orders with type = 'courier'" do
    user = User.create!(name: "User 4", email: "test4@test.com", password: "password")
    address = Address.create!(street_address: "Street 4", city: "City 4", postal_code: "11114")
    restaurant = Restaurant.create!(user: user, address: address, name: "Restaurant 4", phone: "123456", price_range: 2)
    customer = Customer.create!(user: user, address: address, phone: "123456")
    product = Product.create!(name: "Product 4", cost: 10, restaurant: restaurant)
    order_status = OrderStatus.create!(name: "Order Status 4")
    courier_status = CourierStatus.create!(name: "free")
    courier = Courier.create!(user: user, address: address, phone: "123456", email: "test4@test.com")
    order = Order.create!(restaurant: restaurant, customer: customer, order_status: order_status, restaurant_rating: 4, courier: courier)
    product_order = ProductOrder.create!(product: product, order: order, product_quantity: 2, product_unit_cost: 300)

    get "/api/orders", params: { type: "courier", user_id: courier.id}
    assert_response :ok
    assert_equal [
      {
        id: order.id, 
        customer_id: order.customer.id, 
        customer_name: order.customer.user.name, 
        customer_address: order.customer.address.street_address,
        restaurant_id: order.restaurant.id,
        restaurant_name: order.restaurant.name,
        restaurant_address: order.restaurant.address.street_address,
        courier_id: order.courier&.id,
        courier_name: order.courier&.user&.name,
        status: order.order_status.name,
        products: order.product_orders.map do |po|
        {
          product_id: po.product.id,
          product_name: po.product.name,
          product_quantity: po.product_quantity,
          unit_cost: po.product_unit_cost,
          total_cost: (po.product_quantity * po.product_unit_cost)
        }
        end,
        total_cost: order.total_cost
      }
    ].to_json, response.body
  end

  test "get orders with invalid type parameter" do
    get "/api/orders", params: { type: "bogus", user_id: 1}
    assert_response :unprocessable_entity
    assert_equal "Invalid user type", JSON.parse(response.body)["error"]
  end

  test "get orders with no parameters" do
    get "/api/orders"
    assert_response :bad_request
    assert_equal "Both 'user type' and 'id' parameters are required", JSON.parse(response.body)["error"]
  end

  test "get orders with bogus id" do
    get "/api/orders", params: { type: "customer", user_id: 99}
    assert_response :ok
    assert_equal([].to_json, response.body)
  end

end
