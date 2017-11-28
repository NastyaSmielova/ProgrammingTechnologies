json.extract! flight, :id, :destination, :time, :date, :placesBus, :placesStan, :priceBus, :priceStan, :priceLag, :pricePriv, :created_at, :updated_at
json.url flight_url(flight, format: :json)
