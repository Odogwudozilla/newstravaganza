require 'geocoder'

class Country < ApplicationRecord
  belongs_to :continent
  has_many :news_sources, :dependent => :destroy

  def get_country_map_data
             @mapdata = {}
             mapdata = { :c_id => self.id, :name => self.name , :code => self.code, :continent => self.continent.id }
                return mapdata

  end

  geocoded_by :name
  before_save :geocode, if: -> {  self.name.present? } do
  result = Geocoder.search(self.name)
  self.latitude, self.longitude = result.lat, result.lng
end
end


  #after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

# def name
#       [id, name, code, continent_id].compact.join(', ')
# end
