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

        def getAccount
            id = params[:id]
            type = params[:type]
            if type == nil && id == nil
                return render json: {error: "Both 'type' and 'id' parameters are required" }, status: :bad_request
            elseif type == nil
                return render json: {error: "Missing type parameter" }, status: :unprocessable_entity
            elseif id == nil
                return render json: {error: "Missing id parameter" }, status: :unprocessable_entity
            else
                unless type.in?(["customer", "courier"])
                    return render json: {error: "Invalid type" }, status: :unprocessable_entity
                end
                user = User.find_by(id: id)
                unless user.present?
                    return render json: {error: "Invalid user ID" }, status: :unprocessable_entity
                end
                if type == "courier"
                    courier = Courier.find_by(user_id: id)   
                    if courier.present?
                        return render json: {success: true, phone: courier.phone, email: courier.email, login: user.email}, status: :ok
                    else
                        return render json: {error: "Invalid user ID" }, status: :unprocessable_entity
                    end
                else 
                    customer = Customer.find_by(user_id: id)
                    if customer.present?
                        return render json: {success: true, phone: customer.phone, email: customer.email, login: user.email}, status: :ok
                    else
                        return render json: {error: "Invalid user ID" }, status: :unprocessable_entity
                    end
                end
                render json: {success: false}, status: :ok
            end
        end

        def updateAccount
            type, id, phone, email = params.values_at(:type, :id, :phone, :email)

            # Validate required parameters
            unless type.present? && id.present?
                return render json: {error: "Type and ID are required"}, status: :bad_request
            end
            # Validate required parameters
            unless phone.present? || email.present?
                return render json: {error: "phone or email (or both) are required"}, status: :bad_request
            end
            unless type.in?(["customer", "courier"])
                return render json: {error: "Invalid type" }, status: :unprocessable_entity
            end
            if type == "courier"
                courier = Courier.find_by(user_id: id)   
                if courier.present?
                    if phone.present?
                        courier.phone = phone
                    end
                    if email.present?
                        courier.email = email
                    end
                    courier.save
                    return render json: {success: true}, status: :ok
                else
                    return render json: {error: "Invalid user ID" }, status: :unprocessable_entity
                end
            else 
                customer = Customer.find_by(user_id: id)
                if customer.present?
                    if phone.present?
                        customer.phone = phone
                    end
                    if email.present?
                        customer.email = email
                    end
                    customer.save
                    return render json: {success: true}, status: :ok
                else
                    return render json: {error: "Invalid user ID" }, status: :unprocessable_entity
                end
            end
        end
    end
end