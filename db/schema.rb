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

ActiveRecord::Schema.define(version: 2020_04_01_023811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "big_mac_indices", force: :cascade do |t|
    t.date "date"
    t.string "iso_a3", limit: 3
    t.string "currency_code", limit: 3
    t.string "name"
    t.decimal "local_price"
    t.decimal "dollar_ex"
    t.decimal "dollar_price"
    t.decimal "USD_raw"
    t.decimal "EUR_raw"
    t.decimal "GBP_raw"
    t.decimal "JPY_raw"
    t.decimal "CNY_raw"
    t.decimal "GDP_dollar"
    t.decimal "adj_price"
    t.decimal "USD_adjusted"
    t.decimal "EUR_adjusted"
    t.decimal "GBP_adjusted"
    t.decimal "JPY_adjusted"
    t.decimal "CNY_adjusted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
