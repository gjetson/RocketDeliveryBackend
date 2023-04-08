json.extract! address, :id, :street_address, :city, :postal_code, :created_at, :updated_at
json.url address_url(address, format: :json)
