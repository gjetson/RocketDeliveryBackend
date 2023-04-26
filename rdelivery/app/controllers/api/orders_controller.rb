module Api
    class OrdersController < ActionController::Base
        skip_before_action :verify_authenticity_token
        def status
            status = params[:status]
            id = params[:id]
            unless status.in?(["pending", "in progress", "delivered"])
                return render json: { success: false }, status: :unprocessable_entity
            end
            order = Order.find_by(id: id)
            if order == nil
                return render json: {error: "invalid order ID" }, status: :unprocessable_entity
            end
            order_status = OrderStatus.find_by(name: status)
            order.order_status_id = order_status.id
            order.save
            return render json: {success: true }, status: :ok
         end

         def index
            type = params[:type]
            id = params[:user_id]
            if type == nil && id == nil
                return render json: {error: "Both 'user type' and 'id' parameters are required" }, status: :bad_request
            elseif type == nil
                return render json: {error: "Missing type parameter" }, status: :unprocessable_entity
            elseif id == nil
                return render json: {error: "Missing id parameter" }, status: :unprocessable_entity
            else
                unless type.in?(["customer", "restaurant", "courier"])
                    return render json: {error: "Invalid user type" }, status: :unprocessable_entity
                end
                orders = Order.user_orders(type, id)
                # return render json: orders, status: :ok
                return render json: orders.map(&method(:format)), status: :ok
            end
         end

        #  def create
        #     json = JSON.parse(request.body.read)
        #     restaurant = json["restaurant"]
        #     customer = json["customer"]
        #     order_status = json["order_status"]

        #     order = Order.create!(restaurant_id: restaurant, customer_id: customer, order_status_id: order_status)
        #     return render json: {success: true , id: order.id}, status: :ok
        #  end

        # POST /api/order
        def create
            restaurant_id, customer_id, products = params.values_at(:restaurant_id, :customer_id, :products)
  
            # Validate required parameters
            unless restaurant_id.present? && customer_id.present? && products.present?
                return render_400_error("Restaurant ID, customer ID, and products are required")
            end
  
            restaurant = Restaurant.find_by(id: restaurant_id)
            customer = Customer.find_by(id: customer_id)
  
            # Validate foreign keys exists
            unless restaurant && customer
                return render_422_error("Invalid restaurant or customer ID")
            end
  
            order = Order.create!(restaurant_id: restaurant_id, customer_id: customer_id, order_status_id: OrderStatus.find_by(name: "pending")&.id)
  
            # Validate order
            unless order
                return render_422_error("Failed to create order")
            end
  
            # Validate and create product orders
            products.each do |product_params|
                product = Product.find_by(id: product_params[:id])
          
                unless product
                    order.destroy
                    return render_422_error("Invalid product ID")
                end
    
                order.product_orders.create!(product_id: product.id, product_quantity: product_params[:quantity].to_i, product_unit_cost: product.cost)
            end
  
            render json: format(order), status: :created
        end

        private

         def format(order)
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
                created_at: order.created_at,
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
         end
    end
end




