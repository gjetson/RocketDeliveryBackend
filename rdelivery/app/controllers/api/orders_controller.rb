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
            user_id = params[:user_id]
            if type == nil && user_id == nil
                return render json: {error: "Both 'user type' and 'id' parameters are required" }, status: :bad_request
            elseif type == nil
                return render json: {error: "Missing type parameter" }, status: :unprocessable_entity
            elseif user_id == nil
                return render json: {error: "Missing id parameter" }, status: :unprocessable_entity
            else
                unless type.in?(["customer", "restaurant", "courier"])
                    return render json: {error: "Invalid user type" }, status: :unprocessable_entity
                end
                array = Array.new
                return render json: array, status: :ok
            end
         end
    end
end




