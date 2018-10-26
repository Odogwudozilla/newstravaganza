class NewsSource < ApplicationRecord
   belongs_to :category
   belongs_to :country
   belongs_to :language
   
end
