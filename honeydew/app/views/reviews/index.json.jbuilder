json.array!(@reviews) do |review|
  json.extract! review, :id, :task_id, :user_id, :body, :score, :poster_id
  json.url review_url(review, format: :json)
end
