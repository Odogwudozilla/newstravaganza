require 'open-uri'
require 'webhoseio'

namespace :data do

# Pulls info from API and writes to the categories table
  desc "Write to the categories table"
  task category_seed: :environment do

    url = 'https://newsapi.org/v2/sources?apiKey=01d52a3340e742b78df8736185a6087e'
    req = open(url)
    response_body = req.read

    # check if response from API is not empty before clearing database
    if response_body != ''
      Category.destroy_all
    end

    serialized_object = JSON.parse(response_body)

    # Empty array to hold category contents
    category_array = []
    counter = 0

    # iterate through sources and pull categories into an array
    serialized_object["sources"].each do | article |
      category_array << article["category"]
      counter += 1
      puts "#{counter} categories added to array"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    end

    # Strip out duplicate valuse from the array
    category_array = category_array.uniq

    # Create categories from the unique array values
    category_array.each do |value|
      Category.create!(
        name: value
      )
      puts "Category added to array with name: #{value}"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    end
    # send message to the console
    puts "Standard categories created \n\n"

    # Creates a dummy category to accommodate unknown values in sources
    Category.create!(
      name: "Unknown"
    )
    # send message to the console
    puts "Unknown category created also\n\n"
    # send final message to console
    puts '********* Categories Seeded from API to Database successfully! *********'
  end

# ------------------------------------------------------------------------------- #





# Pulls info from API and writes to the sources table
  desc "Write to the Sources table"
  task sources_seed: :environment do

    url = 'https://newsapi.org/v2/sources?apiKey=01d52a3340e742b78df8736185a6087e'
    req = open(url)
    response_body = req.read

    # check if response from API is not empty before clearing database
    if response_body != ''
      # Source.destroy_all
      NewsSource.destroy_all
    end

    serialized_object = JSON.parse(response_body)

    # iterate through sources printing properties
    serialized_object['sources'].each do | article |
      puts article['category']
      puts article['language']
      puts article['country']

      # get category name from article
      category_name = article['category']
      language_code = article['language']
      country_code = article['country'].upcase


      # retrieve category with same name from db
      category = Category.find_by(:name => category_name)
      language = Language.find_by(:code => language_code)
      country = Country.find_by(:code => country_code)

      # ensure category exists first before anything
      if category != nil && language != nil && country != nil

        # insert item to db
        NewsSource.create!(
          identity: article['id'],
          name: article['name'],
          category_id: category.id,
          language_id: language.id,
          country_id: country.id
        )

        # send message to console
      puts "Sources created for this paticular data-point: #{article.inspect}\n\n"

      else
        # retrieve unknown category from db
        category = Category.find_by(:name => 'Unknown')
        language = Language.find_by(:code => 'UKN')
        country = Country.find_by(:code => 'UKN')

        if category != nil

          # insert item to db
          NewsSource.create!(
            identity: article['id'],
            name: article['name'],
            category_id: category.id,
            language_id: language.id,
            country_id: country.id
          )

          # send message to console
          puts "Sources created for this paticular data-point: #{article.inspect}\n\n"
        else
          # send errror message to console
          puts "Category not found for this particular data-point: #{article.inspect}"
        end
      end
    end

    puts '********* Sources Seeded from API to database successfully! **************'
  end
# ------------------------------------------------------------------------------- #





# Pulls info from CSV and writes to the Continents table
desc "Write to the Continents table"
  task continents_seed: :environment do
    unique_konti = []

    CSV.foreach("lib/assets/Countries and Continents data.csv", :headers =>true) do |row |
      # parse values into an array
      unique_konti <<  row[5]
    end
    # strip out unique values
    unique_konti = unique_konti.uniq
    # posts result to console
    puts unique_konti
    # Clear existing data if any
    Continent.destroy_all


    unique_konti.each do | konti|
      # insert item to db
        Continent.create!(
          name: konti
        )
      # send message to console
      puts "Continent of #{konti} created \n\n"

    end
    puts '********* Continents Seeded from CSV file to database successfully! **************'
  end

  # ------------------------------------------------------------------------------- #





# Pulls info from CSV and writes to the Countries table
  desc "Write to the Countries table"
  task countries_seed: :environment do

    # Clear existing data if any
    Country.destroy_all

    CSV.foreach("lib/assets/Countries and Continents data.csv", :headers =>true) do |row |

      # retrieve continent with same name from db
      kontinent = Continent.find_by(:name => row[5])

      # insert item to db
        Country.create!(
          name: row[0],
          code: row[1],
          continent_id: kontinent.id

        )

        # send message to console
      puts "Country #{row[0]} created with Continent as #{kontinent.name}\n\n"

    end

    # Creates a dummy country to accommodate unknown values in sources
        Country.create!(
          name: "Unknown",
          code: "UKN",
          continent_id: Continent.first.id
        )
       puts "Dummy Country created"

    puts "********* #{Country.count} Countries Seeded from CSV file to database successfully! **************"

  end
# ------------------------------------------------------------------------------- #







# Pulls info from CSV and writes to the Keywords table
  desc "Write to the Keywords table"
  task keywords_seed: :environment do

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
# ------------------------------------------------------------------------------- #


# Pulls info from API and writes to the languages table
  desc "Write to the languages table"
  task languages_seed: :environment do

    url = 'https://pkgstore.datahub.io/core/language-codes/language-codes-3b2_json/data/529809cd9e4c8829ec80dc4d2b2997e9/language-codes-3b2_json.json'
    req = open(url)
    response_body = req.read

    # check if response from API is not empty before clearing database
    if response_body != ''
      Language.destroy_all
    end

    serialized_object = JSON.parse(response_body)

    # iterate through API object and pull values into an array
    serialized_object.each do |lang|
      

      lang_name = lang["English"] 
      lang_code = lang["alpha2"]
      
    
        # # insert item to db
        Language.create!(
          name: lang_name,
          code: lang_code

         )

      

      puts "Language name \"#{lang_name}\" created with code as \"#{lang_code}\"\n\n"
      puts "___________________"
    end

    # Creates a dummy language to accommodate unknown values in sources
        Language.create!(
          name: "Unknown",
          code: "UKN"
        )
        puts "Dummy language created"

    # send final message to console
     puts "********* Total of  \"#{Language.count}\" Languages Seeded from API to Database successfully! *********"
  end

# ------------------------------------------------------------------------------- #




# Pulls info from API and writes to the languages table
  desc "Write to the languages table"
  task articles_seed: :environment do

    url = 'https://newsapi.org/v2/top-headlines?language=en&pageSize=100&apiKey=01d52a3340e742b78df8736185a6087e'
    req = open(url)
    response_body = req.read

    # check if response from API is not empty before clearing database
    if response_body != ''
      Article.destroy_all
    end

    serialized_object = JSON.parse(response_body)
    puts serialized_object['articles'][0]['source']['name']

    # iterate through API object and pull values into an array
    serialized_object['articles'].each do | articula |

      category_iwant = NewsSource.find_by(:name => articula['source']['name'])

      # retrieve category with same name from db
      source_id = NewsSource.find_by(:identity => articula['source']['id'])
      language = NewsSource.find_by(:language_id => category_iwant.language_id)
      category = NewsSource.find_by(:category_id => category_iwant.category_id)



        # insert item to db
        Article.create!(
          author: articula['author'],
          title: articula['title'],
          description: articula['description'],
          url: articula['url'],
          url_image: articula['urlToImage'],
          published_date: articula['publishedAt'],
          content: articula['content'],
          language: language.language.code,
          category_id: category.category.id,
          news_source_id: source_id.id
        )
         puts "Article with content \"#{articula['content']}\" created with category as \"#{category.category.name}\" and source as \"#{source_id.name}\"\n\n"
      puts "___________________"

    end

    puts "******************** Articles seeded from API to database successfully *****************"

  end

# ------------------------------------------------------------------------------- #




# Pulls info from API and writes to the Articles table
  desc "Write to the Usersearches table"
  task usersearches_seed: :environment do

    to_week = Date.today
    from_week = 7.days.before(to_week)
    all_keywords = Keyword.all


      Usersearch.destroy_all

    all_keywords.each do |keyword|

      urle = "https://newsapi.org/v2/everything?q=#{keyword.keyword}&from=#{from_week}&to=#{to_week}&pageSize=10&page=3&language=en&apiKey=01d52a3340e742b78df8736185a6087e"
      req = open(urle)
      response_body = req.read

      serialized_object = JSON.parse(response_body)

      # iterate through API object and pull values into an array
    serialized_object['articles'].each do | articula |

      category_iwant = NewsSource.find_by(:name => articula['source']['name'])

      # retrieve category with same name from db
      source_id = NewsSource.find_by(:identity => articula['source']['id'])
      category = NewsSource.find_by(:category_id => category_iwant.category_id)
      keyword_id = Keyword.find_by(:keyword => keyword.keyword)
      rand_count = rand(7...57)

       # ensure category exists first before anything
      if category != nil
        # insert item to db
        Usersearch.create!(
          description: articula['description'],
          count: rand_count,
          keyword_id: keyword_id.id,
          category_id: category.category.id,
          news_source_id: source_id.id
        )
         puts "Usersearches with description \"#{articula['description']}\" created with count as \"#{rand_count}\" and source as \"#{source_id.name}\"\n\n"
      puts "___________________"

    end

    puts "******************** Usersearches seeded from API to database successfully *****************"


    end


  end
# ------------------------------------------------------------------------------- #


desc "Write to the Articles table"
  task stats: :environment do
    # def total_hitrate
      @total_hits = 0
      Keyword.all.each do |key|
        puts key.hit_rate
        @total_hits += key.hit_rate
        puts @total_hits
      end
      puts "the total number of hits is #{@total_hits} "
    # end
    array_tot = []
    array_keyword = []
    tot = 0
    # def each_percent
      Keyword.all.each do |key|
        @pie_percent = (key.hit_rate.to_f / @total_hits.to_f) * 100
        tot += @pie_percent
        array_tot << @pie_percent
        array_keyword << key.keyword.titleize
        puts @pie_percent
    end

    puts tot
    print array_tot
    puts
    puts array_keyword
    # total_hitrate
    # each_percent
  end
end


# to run both the category_seed and source_seed rake tasks at same time
  desc "Run all (included) rake tasks"
  task :all => [:continents_seed, :countries_seed, :keywords_seed, :languages_seed , :category_seed, :sources_seed, :articles_seed ]

end
