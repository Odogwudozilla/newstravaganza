class NewsController < ApplicationController

  def index


      # @all_articles = newsapi.get_sources(country: 'us', language: 'en')
      # @top_headlines = newsapi.get_top_headlines(q: 'bitcoin',
      #                                            sources: 'bbc-news,the-verge',
      #                                            category: 'business',
      #                                            language: 'en')

         # @top_headlines =  get_top_news(country:'us')
         @top_headlines = get_all_news(q: 'hauwa')

          #  url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=18aaacfb0dd14d53983514dd807bc2f7'
          #  response = HTTParty.get(url)
          # @top_headlines = response.parsed_response


  end



end
