# json.extract! country , :id, :name , :content , :code , :created_at, :updated_at



json.extract! country , :id, :name , :continent , :code , :created_at, :updated_at


json.url country_url(country, format: :json)
