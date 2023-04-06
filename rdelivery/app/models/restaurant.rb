class Restaurant < ApplicationRecord
    belongs_to :address
    belongs_to :user
    has_many :products
    has_many :orders
end
