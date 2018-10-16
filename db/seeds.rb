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
  continents = ["Asia" , "Africa", "North America" , "South America" , "Antarctica" , "Europe" , "Australia" ]
  continents.each do |c|
    Continent.create(name: c)
  end
end


def seed_countries

  puts "first--"
  countries = HTTParty.get("https://datahub.io/core/country-list/r/0.html")
  @parsed_countries ||= Nokogiri::HTML(doc)
  puts "first"
  country_name = @parsed_countries.css(".htLeft").css(".htDimmed").css("td").children.map { |name| name.text }.compact
  # country_code =
  puts "get here"
  puts country_name

end

def seed_categories

end

def seed_sources

end

def seed_countries

end

   seed_continents

  # seed_countries
