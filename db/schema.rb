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

ActiveRecord::Schema.define(version: 20170305202212) do

  create_table "groups", force: :cascade do |t|
    t.string   "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "include_in_report", default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.string   "email"
    t.integer  "shoretel",   limit: 8
    t.integer  "cell",       limit: 8
    t.integer  "fax",        limit: 8
    t.string   "group"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "job_id"
  end

end
