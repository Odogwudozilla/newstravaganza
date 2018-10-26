class Country < ApplicationRecord
  belongs_to :continent
  has_many :news_sources
end
