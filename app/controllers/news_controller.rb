class NewsController < ApplicationController

        def index

                # @top = get_all_news(q: "hauwa")
                @top_headlines = get_top_news()
        end


        def search
           @keyword = params[:q]

           keyword_exist = Keyword.find_by(keyword: @keyword)

           if keyword_exist == true
               keyword_exist.hit_rate +=  1
               keyword_exist.save
               @usersearch = Usersearch.create!(q: @keyword , status: @results.status , totalresults: @results.totalResults)

           else
               new_keyword = Keyword.new(keyword: @keyword , hit_rate: 0)
               new_keyword.save
               @usersearch = Usersearch.create!(q: @keyword , status: @results.status , totalresults: @results.totalResults)
           end



          @results = get_all_news(q: @keyword)
          @top = get_top_news(q: @keyword)


          redirect_to usersearches_search_path

        end

      def usersearch_params
          params.permit(:q)
      end

end
