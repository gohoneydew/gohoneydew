json.array!(@todoitems) do |todoitem|
  json.extract! todoitem, :id, :body, :completed, :task_id
  json.url todoitem_url(todoitem, format: :json)
end
