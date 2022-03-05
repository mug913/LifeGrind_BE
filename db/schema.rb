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

ActiveRecord::Schema.define(version: 2022_03_05_040620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.integer "streak"
    t.integer "level"
    t.bigint "user_id", null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_areas_on_user_id"
  end

  create_table "records", force: :cascade do |t|
    t.datetime "date"
    t.string "detail_1_type"
    t.string "detail_1_data"
    t.string "detail_2_type"
    t.string "detail_2_data"
    t.string "detail_3_type"
    t.string "detail_3_data"
    t.bigint "subarea_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subarea_id"], name: "index_records_on_subarea_id"
  end

  create_table "subareas", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.integer "streak"
    t.integer "level"
    t.bigint "area_id", null: false
    t.string "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_subareas_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "areas", "users"
  add_foreign_key "records", "subareas"
  add_foreign_key "subareas", "areas"
end
