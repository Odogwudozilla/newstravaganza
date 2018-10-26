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



        def create

          #  form_params =  usersearch_params
          #  @fkeyword = params[:keyword]
          #  new_keyword = Keyword.where(:keyword => @fkeyword )
          #     puts form_params
          # # if new_keyword == false || new_keyword == nil
          # #       # @keyword = Keyword.usersearches.build(keyword: @fkeyword ,  hit_rate: 1) )
          # #       form_params[:usersearch][:keyword] = Keyword.new(keyword: @fkeyword , hit_rate: 1)
          # #       new_keyword.save
          # # els
          #
          # if new_keyword == true
          #    new_keyword.hit_rate += 1
          #    new_keyword.save
          # end

           puts usersearch_params[:usersearch]

            @usersearch = Usersearch.new(usersearch_params[:usersearch])
              respond_to do |format|
                if @usersearch.save
                  format.html { redirect_to @usersearch, notice: 'User sEARCH was successfully created.' }
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
               keyword = Keyword.find_or_create_by(keyword: @keyword)
               Keyword.increment_counter(:hit_rate, keyword.id)
               @usersearch = Usersearch.new(keyword: keyword )
               @usersearch.save
       puts get_top_keywords
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
