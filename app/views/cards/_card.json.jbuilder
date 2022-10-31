json.extract! card, :id, :score, :shots, :length, :user_id, :course_id, :tee, :created_at, :updated_at
json.url card_url(card, format: :json)
