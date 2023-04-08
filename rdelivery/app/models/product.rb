class Product < ApplicationRecord
    belongs_to :restaurant
    has_many :product_orders
end
