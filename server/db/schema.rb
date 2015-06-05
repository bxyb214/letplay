# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150529130406) do

  create_table "activities", force: :cascade do |t|
    t.text     "description",        limit: 65535
    t.datetime "start_time"
    t.datetime "created_time"
    t.datetime "updated_time"
    t.integer  "max_number",         limit: 4
    t.string   "image_url",          limit: 255
    t.decimal  "location_longitude",               precision: 10
    t.decimal  "location_latitude",                precision: 10
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "title",              limit: 255
    t.boolean  "acceptable",         limit: 1
    t.string   "location",           limit: 255
    t.datetime "end_time"
    t.integer  "user_id",            limit: 4
    t.decimal  "distance",                         precision: 10
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "participates", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "activity_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "participates", ["activity_id"], name: "index_participates_on_activity_id", using: :btree
  add_index "participates", ["user_id"], name: "index_participates_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "baby_name",     limit: 255
    t.integer  "baby_age",      limit: 4
    t.string   "password",      limit: 255
    t.string   "email",         limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "avatar",        limit: 255
    t.string   "global_key",    limit: 255
    t.string   "path",          limit: 255
    t.string   "slogan",        limit: 255
    t.date     "baby_birthday"
    t.string   "baby_hobby",    limit: 255
    t.string   "baby_school",   limit: 255
    t.integer  "sex",           limit: 4
    t.integer  "baby_sex",      limit: 4
    t.string   "introduction",  limit: 255
  end

  add_foreign_key "activities", "users"
end
