class Keyword < ApplicationRecord
  has_many :usersearches, :dependent => :destroy
  accepts_nested_attributes_for :usersearches
end
