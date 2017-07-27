json.extract! poll, :id, :name, :description, :status, :started_at, :concluded_at, :created_at, :updated_at
json.url poll_url(poll, format: :json)
