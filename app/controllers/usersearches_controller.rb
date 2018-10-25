class UsersearchesController < ApplicationController


        # GET /countries
        # GET /countries.json
        def index
          @usersearch = Usersearch.all
        end

        # GET /countries/1
        # GET /countries/1.json
        def show
        end

        # GET /countries/new
        def new

          @usersearch = Usersearch.new

        end

        # GET /countries/1/edit
        def edit
        end



        def create      #




           puts usersearch_params[:usersearch]

            @usersearch = Usersearch.new(usersearch_params[:usersearch])
              respond_to do |format|
                if @usersearch.save
                  format.html { redirect_to @usersearch, notice: 'User search was successfully created.' }
                  # format.json { render :show, status: :created, location: @country }
                else
                  format.html { render :new }
                  # format.json { render json: @usersearch.errors, status: :unprocessable_entity }
                end
              end

           # redirect_to @usersearch
          # redirect_to searchResult_path
        end




        # def show
        #   @usersearch = Usersearch.find(params[:id])
        # end



        def search

               @keyword = params[:q]
               @results = get_all_news(q: @keyword)
               @top = get_top_news(q: @keyword)
               @usersearch = Usersearch.new(keyword: @keyword , status: @results.status , totalresults: @totalResults )
              # @results = get_all_news(q: params[:keyword] ,
              #                         sources: params[:source] ,
              #                         from: params[:from] ,
              #                         to: params[:to] ,
              #                         language: params[:language] ,
              #                         pageSize: params[:pageSize] ,
              #                         page: params[:page]

              #

        end



        private
          # Use callbacks to share common setup or constraints between actions.
          def set_usersearch
            @usersearch = Usersearch.find(params[:id])
          end

          # Never trust parameters from the scary internet, only allow the white list through.
          # def usersearch_params
          #   # params.fetch(:usersearch, {})
          #   params.permit(:usersearch, {})
          # end

          def usersearch_params
              params.permit(:q)
          end

end
