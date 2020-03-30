# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_30_161034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "internet_protocols", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_internet_protocols_on_name", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "continent", null: false
    t.string "country", null: false
    t.string "region", null: false
    t.string "city", null: false
    t.string "zip", null: false
    t.decimal "latitude", precision: 10, null: false
    t.decimal "longitude", precision: 10, null: false
    t.bigint "internet_protocol_id"
    t.index ["city"], name: "index_locations_on_city"
    t.index ["continent"], name: "index_locations_on_continent"
    t.index ["country"], name: "index_locations_on_country"
    t.index ["internet_protocol_id"], name: "index_locations_on_internet_protocol_id", unique: true
    t.index ["latitude"], name: "index_locations_on_latitude"
    t.index ["longitude"], name: "index_locations_on_longitude"
    t.index ["region"], name: "index_locations_on_region"
    t.index ["zip"], name: "index_locations_on_zip"
  end

  add_foreign_key "locations", "internet_protocols"
end
