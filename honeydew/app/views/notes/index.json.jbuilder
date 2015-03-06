json.array!(@notes) do |note|
  json.extract! note, :id, :task_id, :body, :sender_id, :recipient_id
  json.url note_url(note, format: :json)
end
