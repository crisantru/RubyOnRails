json.extract! user, :id, :nombre, :razonSocial, :telefono, :email, :cotizacion, :created_at, :updated_at
json.url user_url(user, format: :json)
