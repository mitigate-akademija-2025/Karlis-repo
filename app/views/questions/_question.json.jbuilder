json.extract! question, :id, :name, :quiz_id, :created_at, :updated_at
json.url question_url(question, format: :json)
