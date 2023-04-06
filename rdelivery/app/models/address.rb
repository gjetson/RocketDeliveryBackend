class Address < ApplicationRecord
    has_many :employees
    has_many :customers
    has_many :restaurants
end
