json.array!(@sales_articles) do |sales_article|
  json.extract! sales_article, :id
  json.url sales_article_url(sales_article, format: :json)
end
