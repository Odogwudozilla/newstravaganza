desc "This task is called by the Heroku scheduler add-on"
task :update_keywords => :environment do
  
    #grabs the keywords data from API with API key
    webhoseio = Webhoseio.new('f792ec54-82f9-490f-89ab-f5cd43bdb265')
    query_params = {
    "q" => " site_type:news domain_rank:<1000 social.facebook.shares:>1000 performance_score:>9 language:english",
    "ts" => "1539755202162",
	  "sort" => "relevancy"
    }
    keyword_output = webhoseio.query('filterWebContent', query_params)

    # check if response from API is not empty before clearing database
    if keyword_output != ''
      # Keyword.destroy_all
      Keyword.destroy_all
    end

    # Creates a new hash and ranks keywords according to frequency on news sites
    kvp = Hash.new
    # Grabs 'posts' collection
    keyword_output['posts'].each do |post|
    # Grabs 'entities' collection
      post['entities'].each do |entity|
        # Grabs 'entities' collection
        entity[1].each do |item|
          # Eliminates stings less than 5
              if item['name'].length >4
                # Checks if key-value pair exists
                if kvp.key?(item['name'])
                  kvp[item['name']] += 1
                else
                  kvp[item['name']] = 1
                end
              end
            end
          end
      end
    # Sorts list according to frequency and takes first 20
    sorted_kvp = kvp.sort_by{ |k,v| v }.reverse.take(20)
    puts sorted_kvp.inspect
    sorted_kvp.each do |keyword|

    # insert item to db
        Keyword.create!(
          keyword: keyword[0],
          hit_rate: keyword[1]

        )
        puts "Keyword \"#{keyword[0]}\" created with Hit_rate as \"#{keyword[1]}\"\n\n"
    end
        # send message to console
     puts "********* \'#{Keyword.count}\' Keywords Seeded from API to database successfully! **************"
end

