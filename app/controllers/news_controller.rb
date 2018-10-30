class NewsController < ApplicationController

    include ::Newschart

        def index

                @top_headlines = get_top_news
                @top_keywords = get_top_keywords
                @top_searches = get_top_search_news
        end


        def more_news

                @result = get_top_news
                
        end
end
