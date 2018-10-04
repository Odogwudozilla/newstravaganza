class Article < ApplicationRecord
  belongs_to :source
  belongs_to :country
  belongs_to :category
end
