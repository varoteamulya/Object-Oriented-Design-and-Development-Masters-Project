json.extract! car, :id, :License, :Plate, :Manufacturer, :Model, :Hourly, :Rental, :Rate, :Style, :Location, :Availability, :Checkout, :created_at, :updated_at
json.url car_url(car, format: :json)
