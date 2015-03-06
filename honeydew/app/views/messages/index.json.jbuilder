json.array!(@messages) do |message|
  json.extract! message, :id, :sender_id, :recipient_id, :subject, :body, :task_id, :proposed_price, :wallet_price
  json.url message_url(message, format: :json)
end
