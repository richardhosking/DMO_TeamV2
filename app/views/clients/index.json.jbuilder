json.array!(@clients) do |client|
  json.extract! client, :id, :firstname, :, :surname, :, :urn, :, :dd, :, :mm, :, :yyyy, :
  json.url client_url(client, format: :json)
end
