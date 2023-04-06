class Order < ApplicationRecord
    belongs_to :order_status
    belongs_to :restaurant
    belongs_to :customer
    has_many :product_orders
end
