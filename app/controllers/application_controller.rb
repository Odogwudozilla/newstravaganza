require 'news-api'
require 'httparty'
require 'open-uri'
require 'resolv-replace'

class ApplicationController < ActionController::Base

# set per_page globally
# WillPaginate.per_page = 20

    #get the news site apikey and store in a variable

     # @@news_api_key  = '9b9bcccf834b4b42ac012658cf230727'
     @@news_api_key = '01d52a3340e742b78df8736185a6087e'
     # @@news_api_key = '6ef29d9dba7748a3914b6477bdd7c245'

    #newsapi = News.new("18aaacfb0dd14d53983514dd807bc2f7")

    def get_all_news(options)
        options[:apiKey] = @@news_api_key
        options[:pageSize] = 100
        # mUri = URI("https://newsapi.org/v2/everything?&country=ng&pageSize=100")
        mUri = URI("https://newsapi.org/v2/everything")
        newuri = URI::HTTP.build( host: mUri.host , path: mUri.path , query: options.to_query)
        url = 'https://newsapi.org/v2/everything?country=us&apiKey=01d52a3340e742b78df8736185a6087e'
        response = HTTParty.get(newuri)
        all_headlines = response.parsed_response
        return all_headlines
  end

  def get_our_sources()

  end


    def get_news_source_by_country(country_code)
      options = {}
      options[:country] = country_code.downcase
      options[:apiKey] = @@news_api_key
      url = 'https://newsapi.org/v2/sources?' + 'country=' + country_code.downcase + '&apiKey=01d52a3340e742b78df8736185a6087e'
      # mUri = URI("https://newsapi.org/v2/sources?")
      # newuri = URI::HTTP.build( host: mUri.host , path: mUri.path , query: options.to_query)
      response = HTTParty.get(url)
      news_by_country = response.parsed_response
      return news_by_country
    end





def get_countries__json

     countries = Country.all
     countries_map_data = { 'sources' => 'name' }

     countries.each do |c|
      country_code = (c.name[0..2]).upcase
      country_name = c.name
      if c.name != "Antarctica"
        number_of_sources =  NewsSource.where(country_id: c.id).count

         array =  { "#{number_of_sources}" => "#{country_name}"  }
         countries_map_data.merge!(array)
       end
      end

      return countries_map_data.to_a

 end



  # method definition to get the top news for a country
  def get_top_news(options={})
          if options == {}
              options[:apiKey] = @@news_api_key
              url = 'https://newsapi.org/v2/top-headlines?country=gb&apiKey=01d52a3340e742b78df8736185a6087e'
              response = HTTParty.get(url)
          else
              options[:apiKey] = @@news_api_key
              mUri = URI("https://newsapi.org/v2/top-headlines")
              newuri = URI::HTTP.build( host: mUri.host , path: mUri.path , query: options.to_query)
              response = HTTParty.get(newuri)
            end
            top_headlines = response.parsed_response
       return top_headlines
  end


end

# NewsAPI (2018) News API (Version 2.0) [Source code]. https://newsapi.org
