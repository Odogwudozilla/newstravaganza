require 'open-uri'

namespace :data do

# Pulls info from API and writes to the categories table
  desc "Write to the categories table"
  task category_seed: :environment do

    url = 'https://newsapi.org/v2/sources?apiKey=4b87c3dde8444f4e843dc41ab00f5c18'
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
  task source_seed: :environment do
    
    url = 'https://newsapi.org/v2/sources?apiKey=4b87c3dde8444f4e843dc41ab00f5c18'
    req = open(url)
    response_body = req.read

    # check if response from API is not empty before clearing database
    if response_body != ''
      Source.destroy_all
    end

    serialized_object = JSON.parse(response_body)

    # iterate through sources printing properties
    serialized_object['sources'].each do | article |

      # get category name from article
      category_name = article['category']

      # retrieve category with same name from db
      category = Category.find_by(:name => category_name)

      # ensure category exists first before anything
      if category != nil

        # insert item to db
        Source.create!(
          identity: article['id'],
          name: article['name'],
          category_id: category.id
        )

        # send message to console
      puts "Sources created for this paticular data-point: #{article.inspect}\n\n"

      else
        # retrieve unknown category from db
        category = Category.find_by(:name => 'Unknown')

        if category != nil

          # insert item to db
          Source.create!(
            identity: article['id'],
            name: article['name'],
            category_id: category.id
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

    puts "********* #{Country.count} Countries Seeded from CSV file to database successfully! **************"

  end 
# ------------------------------------------------------------------------------- #



# Pulls info from API and writes to the Articles table
  desc "Write to the Articles table"
  task articles_seed: :environment do
    
    url = 'https://newsapi.org/v2/everything?q=%22Trump%22&from=2018-10-01&to=2018-10-07&pageSize=100&page=3&language=en&apiKey=4b87c3dde8444f4e843dc41ab00f5c18'
    req = open(url)
    response_body = req.read

    serialized_object = JSON.parse(response_body)

    # iterate through sources printing properties
    serialized_object['articles'].each do |sunny|
      puts sunny["author"]
      puts "***"
      puts sunny["title"]
      puts "***"
      puts sunny["description"]
      puts "***"
      puts sunny["url"]
      puts "***"
      puts sunny["urlToImage"]
      puts "***"
      puts sunny["publishedAt"]
      puts "***"
      puts sunny["content"]
      puts "***"
      puts sunny["language"]
      puts "%%%%%%%%%%%%%"
    end
    puts serialized_object['articles'].count

  end 
# ------------------------------------------------------------------------------- #




# to run both the category_seed and source_seed rake tasks at same time
  desc "Run both the category_seed and source_seed rake tasks"
  task :all => [:category_seed, :source_seed, :continents_seed, :countries_seed]

end