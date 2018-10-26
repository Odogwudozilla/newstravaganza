class NewsController < ApplicationController

        def index

                @top_headlines = get_top_news()
                @top_keywords = get_top_keywords
        end


        def search
           @keyword = params[:q]
           @results = get_all_news(q: @keyword)
           @top = get_top_news(q: @keyword)

          redirect_to usersearches_search_path

        end

      def usersearch_params
          params.permit(:q)
      end

end
