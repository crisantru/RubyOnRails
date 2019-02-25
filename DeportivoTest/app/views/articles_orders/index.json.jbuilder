json.array!(@articles_orders) do |articles_order|
  json.extract! articles_order, :id
  json.url articles_order_url(articles_order, format: :json)
end
