class Usersearch < ApplicationRecord
  # belongs_to :keyword
  # before_validation :keyword_attributes, :if => :new_record?
  # validate :keyword_attributes, :on => :new_record
  # before_validation :keyword_attributes
  before_save :keyword_attributes , :if => :new_record?


    def keyword_attributes=(params)
      self.keyword = Keyword.find_or_create_by(keyword: params[0])
      Keyword.increment_counter(:hit_rate, self.keyword.id)
end
end
