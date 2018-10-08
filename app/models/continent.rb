class Continent < ApplicationRecord
  has_many :countries, :dependent => :destroy
end
