json.extract! service_category, :id, :name, :description, :url_name, :created_at, :updated_at
json.url service_category_url(service_category, format: :json)