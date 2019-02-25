json.array!(@staff_types) do |staff_type|
  json.extract! staff_type, :id
  json.url staff_type_url(staff_type, format: :json)
end
