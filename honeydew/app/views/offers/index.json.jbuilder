json.array!(@offers) do |offer|
  json.extract! offer, :id, :subject, :task_id, :user_id, :proposed_price, :body, :status, :unnread, :deleted
  json.url offer_url(offer, format: :json)
end
