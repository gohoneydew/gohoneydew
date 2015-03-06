json.array!(@job_categories) do |job_category|
  json.extract! job_category, :id, :name, :jobs_id, :user_generated
  json.url job_category_url(job_category, format: :json)
end
