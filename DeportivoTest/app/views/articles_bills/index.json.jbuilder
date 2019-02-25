json.array!(@articles_bills) do |articles_bill|
  json.extract! articles_bill, :id
  json.url articles_bill_url(articles_bill, format: :json)
end
