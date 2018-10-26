class Usersearch < ApplicationRecord
  belongs_to :keyword
  belongs_to :category
  belongs_to :news_source

end
