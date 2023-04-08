json.extract! order, :id, :restaurant_id, :customer_id, :order_status_id, :restaurant_rating, :created_at, :updated_at
json.url order_url(order, format: :json)
