require 'open-uri'
class Country < ApplicationRecord

  belongs_to :continent
  has_many :news_sources, :dependent => :destroy

  geocoded_by :name, latitude: :lat, longitude: :lon
  before_save :geocode, if: -> {  self.name.present? } # do
  #   result = Geocoder.search(self.name)
  #   coordinates = results.first.coordinates
  #   self.latitude, self.longitude = coordinates[0], coordinates[1]
  # end

  def get_country_map_data
             @mapdata = {}
             # coordinates = Geocoder.search(self.name)
             mapdata = { :c_id => self.id, :name => self.name , :code => self.code, :continent => self.continent.id , :long => self.longitude , :lat => self.latitude }
                return mapdata

  end


end


  #after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

# def name
#       [id, name, code, continent_id].compact.join(', ')
# end
