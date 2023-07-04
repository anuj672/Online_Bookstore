json.extract! cart, :id, :credit_card_number, :address, :phone_number, :user_id, :created_at, :updated_at
json.url cart_url(cart, format: :json)
