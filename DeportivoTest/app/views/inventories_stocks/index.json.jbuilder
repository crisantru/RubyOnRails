json.array!(@inventories_stocks) do |inventories_stock|
  json.extract! inventories_stock, :id
  json.url inventories_stock_url(inventories_stock, format: :json)
end
