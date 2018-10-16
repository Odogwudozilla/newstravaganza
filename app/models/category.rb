class Category < ApplicationRecord
   has_many :news_sources, :dependent => :destroy
end
