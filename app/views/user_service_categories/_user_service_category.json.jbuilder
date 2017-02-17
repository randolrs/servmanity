json.extract! user_service_category, :id, :user_id, :service_category_id, :description, :hourly_rate, :created_at, :updated_at
json.url user_service_category_url(user_service_category, format: :json)