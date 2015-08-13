json.array!(@posts) do |post|
  json.extract! post, :id, :title, :description, :status
  json.url post_url(post, format: :json)
end
