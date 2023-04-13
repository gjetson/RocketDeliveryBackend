module Api
    class AuthController < ActionController::Base
        def index
            json = JSON.parse(request.body.read)
            email = json['email']
            password = json['password']
            
            user = User.find_by(email: email)
            if user.present? && user.valid_password?(password)
                return render json: {success: true}, status: :ok
            end
            render json: {success: false}, status: :unauthorized
        end
    end
end