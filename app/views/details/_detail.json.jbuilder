json.extract! detail, :id, :first_name, :last_name, :organization, :contact_number, :address, :created_at, :updated_at
json.url detail_url(detail, format: :json)
