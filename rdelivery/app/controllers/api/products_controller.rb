module Api
    class ProductsController < ActionController::Base
        def index
            #set restaurant id from params
            restaurant_id = params[:restaurant]
            #if a restaurant id is given
            if restaurant_id.present?
                #find a restaurant using the restaurant id
                restaurant = Restaurant.find_by(id: restaurant_id)
                #if none found
                if restaurant == nil
                    return render json: {error: "Invalid restaurant ID" }, status: :unprocessable_entity
                end
                #otherwise find all products with given restaurant id and only
                #return specified fields (select_short)
                @products = restaurant.products.select_short
            else
                #if no restaurant id given, send back all products
                @products = Product.all
            end
            render json: @products, status: :ok
        end
    end
end