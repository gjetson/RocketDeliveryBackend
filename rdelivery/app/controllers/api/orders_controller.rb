module Api
    class OrdersController < ActionController::Base
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

         def create
            json = JSON.parse(request.body.read)
            restaurant = json["restaurant"]
            customer = json["customer"]
            order_status = json["order_status"]

            order = Order.create!(restaurant_id: restaurant, customer_id: customer, order_status_id: order_status)
            return render json: {success: true }, status: :ok
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




