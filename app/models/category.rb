class Category < ApplicationRecord
   has_many :news_sources, :dependent => :destroy
   has_many :articles, :dependent => :destroy
   has_many :usersearches, :dependent => :destroy
end
