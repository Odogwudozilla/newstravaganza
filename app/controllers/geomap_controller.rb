class GeomapController < ApplicationController
  include ::Geomap
  def geocontinent
    @all_countries = country_data
           # @keyword = params[:name]
           # @results = get_all_news(name: @keyword)
           # @top = get_top_news(name: @keyword)

  end

  def geocountries
  end

  def heatmap
  end 
end
