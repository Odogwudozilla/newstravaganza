#Definition for the Demographic module which contains shared methods for the controllers.
require 'active_support/concern' #loads active_support/concern library

module Geomap

extend ActiveSupport::Concern #inherits from ActiveSupport::Concern class

def country_data
      country = Country.all
      all_countries = []
      country.each do |c|
          all_countries << c.get_country_map_data
     end
      return all_countries
end
end
