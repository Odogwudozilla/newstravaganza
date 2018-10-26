class Country < ApplicationRecord
  belongs_to :continent
  has_many :news_sources, :dependent => :destroy

  def get_country_map_data
             @mapdata = {}
             mapdata = { :c_id => self.id, :name => self.name , :code => self.code, :continent => self.continent.id }
                return mapdata

  end

end
