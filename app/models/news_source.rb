class NewsSource < ApplicationRecord
   belongs_to :category
   belongs_to :country
   belongs_to :language
   has_many :articles, :dependent => :destroy
   has_many :usersearches, :dependent => :destroy
   
end
