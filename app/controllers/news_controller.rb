class NewsController < ApplicationController

  def index

          @top_headlines = get_all_news(q: 'Damilola')

  end


      def search
        @keyword = params[:q]
        @results = get_all_news(q: @keyword)
        @top_headlines = get_top_news(q: @keyword)

        # query = params["q"]
        # keyword_exist = Keyword.find_by(keyword: query.to_s)
        #
        # # @results = get_all_news(q: params["q"])
        # # @top_headlines = get_top_news(q: params["q"])
        #
        # if keyword_exist
        #     keyword_exist.hit_rate +=  1
        #     keyword_exist.save
        #     @usersearch = Usersearch.create!(q: query , status: @results.status , totalresults: @results.totalResults)
        #
        # else
        #     new_keyword = Keyword.new(keyword: query , hit_rate: 0)
        #     new_keyword.save
        #     @usersearch = Usersearch.create!(q: query , status: @results.status , totalresults: @results.totalResults)
        # end

        redirect_to usersearches_search_path

      end

      def usersearch_params
          params.permit(:q)
      end

end
