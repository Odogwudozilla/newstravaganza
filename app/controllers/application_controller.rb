require 'news-api'
require 'httparty'
require 'open-uri'

class ApplicationController < ActionController::Base

    #get the news site apikey and store in a variable
    # @@news_api_key = '01f24e7d9d6f4bf7ba0d928ba22bd050'
    @@news_api_key = '6058bea4bb6e4df897d7ad26cfe3dd71'
    #newsapi = News.new("18aaacfb0dd14d53983514dd807bc2f7")

    def get_all_news(options)
        options[:apiKey] = @@news_api_key
        mUri = URI("https://newsapi.org/v2/everything?&country=ng&pageSize=100")
        newuri = URI::HTTP.build( host: mUri.host , path: mUri.path , query: options.to_query)
        url = 'https://newsapi.org/v2/everything?country=us&apiKey=6058bea4bb6e4df897d7ad26cfe3dd71'
        response = HTTParty.get(newuri)
        all_headlines = response.parsed_response
        return all_headlines
  end

  def get_our_sources

  end


  # method definition to get the top news for a country
  def get_top_news(options={})
          if options == {}
              # options = args[0]
              options[:apiKey] = @@news_api_key
              url = 'https://newsapi.org/v2/top-headlines?country=gb&apiKey=6058bea4bb6e4df897d7ad26cfe3dd71'
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
