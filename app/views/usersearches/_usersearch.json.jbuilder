
json.extract! usersearch , :status, :description , :count , :keyword, :created_at, :updated_at, :news_source_id, :category_id


json.url usersearch_url(usersearch, format: :json)
