class StatisticsController < ApplicationController

   def index
      @total_hits = 0

      Keyword.all.each do |key|
        @total_hits += key.hit_rate
      end 

      @array_tot = []
      @array_keyword = []
    
      Keyword.all.each do |key|
        @pie_percent = (key.hit_rate.to_f / @total_hits.to_f) * 100
        
        @array_tot << @pie_percent.round(2)
        @array_keyword << key.keyword.titleize

      end
  end 

end
