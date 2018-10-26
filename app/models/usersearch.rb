class Usersearch < ApplicationRecord
  belongs_to :keyword
  belongs_to :category , required: false
  belongs_to :news_source , required: false

end
