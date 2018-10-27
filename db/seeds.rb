# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'httparty'
require 'nokogiri'
require 'open-uri'


def seed_continents
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


def seed_countries

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

def seed_categories

end

def seed_sources

end

def seed_countries

end

   seed_continents

  # seed_countries
