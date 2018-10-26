require 'active_support/concern' #loads active_support/concern library

module Newschart

extend ActiveSupport::Concern

def get_top_keywords
  top = Keyword.order(hit_rate: :desc).limit(10)
  top_10 = []
  top.each do |t|
    top_10 << {t.keyword => t.hit_rate}
  end
  return top_10
end


end
