json.extract! pokemon, :id, :nombre, :apodo, :peso, :altura, :vida, :created_at, :updated_at
json.url pokemon_url(pokemon, format: :json)
