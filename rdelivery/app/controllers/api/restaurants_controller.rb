module Api
    class RestaurantsController < ActionController::Base
        def index
            rating = params[:rating]
            price_range = params[:price_range]
            if rating != nil && price_range != nil
                r_int = rating.to_i
                if r_int > 5 || r_int < 1
                    return render json: {error: "Invalid rating or price range" }, status: :unprocessable_entity
                end
                pr_int = price_range.to_i
                if pr_int > 3 || pr_int < 1
                    return render json: {error: "Invalid rating or price range" }, status: :unprocessable_entity
                end
                @restaurants  = Restaurant.rating_and_price(rating, price_range)
            else
                @restaurants  = Restaurant.all
                grouped = []
                @restaurants.each do |r|
                    ave_rating = Order.where(restaurant_id: r.id).average(:restaurant_rating)
                    # puts ave_rating
                    ave_rating = ave_rating.round(0)
                    grouped.push({restaurant: r, ave_rating: ave_rating})
                end
                return render json: grouped, status: :ok
            end
            render json: @restaurants , status: :ok
        end
    end
end