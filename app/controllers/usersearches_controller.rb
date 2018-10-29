class UsersearchesController < ApplicationController

      include ::Newschart
        # GET /countries
        # GET /countries.json
        def index
          @usersearch = Usersearch.all
          @keyword = Keyword.all

          respond_to do |format|
            format.html { return @usersearch}
            format.json { render json: @usersearch.to_json }
          end
          respond_to do |format|
            format.html { return @keyword}
            format.json { render json: @keyword.to_json }
          end
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


        # POST /countries
         # POST /countries.json
         def create

           options = {}

           if params[:q] == true || params[:usersearch] == nil

                @keyword = params[:q]
                keyword = Keyword.find_or_create_by(keyword: @keyword )
                Keyword.increment_counter(:hit_rate, keyword.id)
                @usersearch = Usersearch.new(keyword: keyword )

           else

                @keyword = params[:usersearch][:keyword]
                keyword = Keyword.find_or_create_by(keyword: @keyword )
                Keyword.increment_counter(:hit_rate, keyword.id)

        params[:usersearch].each  do |k, v|
                    if v != "" && v != params[:usersearch][:keyword]
                      hash =  { k => v }
                      options.merge!(hash)
                    end
                end

                  create_usersearch_attr = {keyword: keyword}

              options.each do |k, v|

                 if k != "country" && k != "language"
                   case k
                   when  "news_source"
                         v =   NewsSource.find(v)

                   when  "category"
                         v =   Category.find(v)

                   end

                   hash = { k => v }
                   create_usersearch_attr.merge!(hash)

                end

              end

                  @usersearch = Usersearch.new(create_usersearch_attr)

           end

          if @usersearch.save

              searchoptions = { :keyword => @keyword }

              options.each do |k, v|
                case k
                when  "news_source"
                      v =   NewsSource.find(v).name

                when  "category"
                      v =   Category.find(v).name
                end

                hash = { k => v }
                searchoptions.merge!(hash)

             end

              redirect_to usersearches_search_path(searchoptions)
          else
                format.html { render :new }
                format.json { render json: @usersearch.errors, status: :unprocessable_entity }
          end

         end





         def search

                @keyword = params[:keyword]

                country = params[:country] ? params[:country]: ""
                language = params[:language] ? params[:language] : ""
                source = params[:news_source] ? params[:news_source] : ""
                category = params[:category] ? params[:category] : ""

                @results = get_all_news(q: @keyword , source: source , language: language)
                @top = get_top_news(q: @keyword , country: country , category: category , source: source )
         end



         # PATCH/PUT /countries/1
   # PATCH/PUT /countries/1.json
   def update
     respond_to do |format|
       if @usersearch.update(usersearch_params)
         format.html { redirect_to @usersearch, notice: 'Usersearch was successfully updated.' }
         format.json { render :show, status: :ok, location: @usersearch }
       else
         format.html { render :edit }
         format.json { render json: @usersearch.errors, status: :unprocessable_entity }
       end
     end
   end



   # DELETE /countries/1
   # DELETE /countries/1.json
   def destroy
     @usersearch.destroy
     respond_to do |format|
       format.html { redirect_to usersearch_url, notice: 'Usersearch was successfully destroyed.' }
       format.json { head :no_content }
     end
   end



   private
     # Use callbacks to share common setup or constraints between actions.
     def set_usersearch
       @usersearch = Usersearch.find(params[:id])
     end



     # Never trust parameters from the scary internet, only allow the white list through.
     def usersearch_params

          params.permit( :q , :usersearch => [:keyword , :country_id , :language_id , :category_id , :news_source_id])

     end
 end
