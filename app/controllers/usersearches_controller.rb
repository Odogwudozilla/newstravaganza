class UsersearchesController < ApplicationController


        def new
          @usersearch = Usersearch.new

        end


        def create

            @fkeyword = params[:usersearch][:keyword]
           new_keyword = Keyword.where(:keyword => @fkeyword )

            if new_keyword == false || new_keyword == nil
                  new_keyword = Keyword.create!(keyword: @fkeyword , hit_rate: 1)
                  new_keyword.save
            elsif new_keyword == true
               new_keyword.hit_rate += 1
               new_keyword.save
            end

              @usersearch = Usersearch.create!(usersearch_params)




          redirect_to @usersearch
          # redirect_to searchResult_path
        end

        # def show
        #   @usersearch = Usersearch.find(params[:id])
        # end

        def search
            @results = get_all_news(q: 'hauwa')
              # @results = get_all_news(q: params[:keyword] ,
              #                         sources: params[:source] ,
              #                         from: params[:from] ,
              #                         to: params[:to] ,
              #                         language: params[:language] ,
              #                         pageSize: params[:pageSize] ,
              #                         page: params[:page]

              #                        )
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_usersearch
            @source = Usersearch.find(params[:id])
          end

          # Never trust parameters from the scary internet, only allow the white list through.
          def usersearch_params
            params.require(:keyword).permit(:language, :category, :Country)
          end
end
