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

      source_hash = Hash.new 
      
      source_all = NewsSource.all
      
      source_all.each do |ose|
      
      # Checks if key-value pair exists
        if source_hash.key?(ose.country.name)
          source_hash[ose.country.name] += 1
        else
          source_hash[ose.country.name] = 1
        end
      end 

    # Sorts list according to frequency and takes first 20
   
    @sorted_keys = source_hash.keys
    @sorted_values = source_hash.values

  
  end 

end
