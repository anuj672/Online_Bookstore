json.extract! admin, :id, :username, :password, :name, :email, :created_at, :updated_at
json.url admin_url(admin, format: :json)
