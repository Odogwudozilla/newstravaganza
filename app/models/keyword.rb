class Keyword < ApplicationRecord
  has_many :usersearches
  accepts_nested_attributes_for :usersearches
  validates :keyword, presence: true


end
