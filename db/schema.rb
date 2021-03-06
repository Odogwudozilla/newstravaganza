# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_26_211823) do

  create_table "articles", force: :cascade do |t|
    t.string "author"
    t.string "title"
    t.string "description"
    t.string "url"
    t.string "url_image"
    t.datetime "published_date"
    t.text "content"
    t.string "language"
    t.integer "news_source_id"
    t.integer "country_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["country_id"], name: "index_articles_on_country_id"
    t.index ["news_source_id"], name: "index_articles_on_news_source_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "continents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "continent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["continent_id"], name: "index_countries_on_continent_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "keyword"
    t.integer "hit_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news_sources", force: :cascade do |t|
    t.string "identity"
    t.string "name"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "language_id"
    t.integer "country_id"
    t.index ["category_id"], name: "index_news_sources_on_category_id"
    t.index ["country_id"], name: "index_news_sources_on_country_id"
    t.index ["language_id"], name: "index_news_sources_on_language_id"
  end

  create_table "usersearches", force: :cascade do |t|
    t.string "status"
    t.string "description"
    t.string "count"
    t.integer "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "news_source_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_usersearches_on_category_id"
    t.index ["keyword_id"], name: "index_usersearches_on_keyword_id"
    t.index ["news_source_id"], name: "index_usersearches_on_news_source_id"
  end

end
