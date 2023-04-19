module Api
    class AuthController < ActionController::Base
        skip_before_action :verify_authenticity_token
        def index
            json = JSON.parse(request.body.read)
            email = json['email']
            password = json['password']
            
            user = User.find_by(email: email)
            if user.present? && user.valid_password?(password)
                customer = Customer.find_by(user_id: user.id)
                courier = Courier.find_by(user_id: user.id)   
                if customer.present? && courier.present?
                    return render json: {success: true, customer_id: customer.id, user_id: user.id, courier_id: courier.id}, status: :ok
                elsif customer.present?
                    return render json: {success: true, customer_id: customer.id, user_id: user.id, courier_id: -1}, status: :ok
                elsif courier.present?
                    return render json: {success: true, customer_id: -1, user_id: user.id, courier_id: courier.id}, status: :ok
                else
                    return render json: {success: true, customer_id: -1, user_id: user.id, courier_id: -1}, status: :ok
                end
            end
            render json: {success: false}, status: :unauthorized
        end
    end
end