class Keyword < ApplicationRecord
  has_many :usersearches, :dependent => :destroy
  accepts_nested_attributes_for :usersearches
  validates :keyword, presence: true


end

# Webhose (2018) Keyword [Source code]. https://webhose.io
