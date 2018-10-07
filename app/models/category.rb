class Category < ApplicationRecord
  has_many :sources, :dependent => :destroy
end
