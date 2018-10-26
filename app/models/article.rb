class Article < ApplicationRecord
  belongs_to :news_source
  belongs_to :category
end
