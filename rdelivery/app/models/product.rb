class Product < ApplicationRecord
    belong_to :restaurant
    has_many :product_orders
end
