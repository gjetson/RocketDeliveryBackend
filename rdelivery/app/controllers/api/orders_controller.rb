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
    end
end




