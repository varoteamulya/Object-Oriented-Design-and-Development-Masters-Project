json.extract! user, :id, :email_id, :name, :password, :u_type, :created_at, :updated_at
json.url user_url(user, format: :json)
