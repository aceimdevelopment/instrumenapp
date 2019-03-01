json.extract! user, :id, :id, :name, :full_name, :email, :phone, :password, :type, :created_at, :updated_at
json.url user_url(user, format: :json)
