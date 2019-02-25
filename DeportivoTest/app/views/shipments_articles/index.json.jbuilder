json.array!(@shipments_articles) do |shipments_article|
  json.extract! shipments_article, :id
  json.url shipments_article_url(shipments_article, format: :json)
end
