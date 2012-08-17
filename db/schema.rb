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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120816200312) do

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.string   "location"
    t.text     "content"
    t.string   "web_source"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "uuid"
    t.string   "detail_url"
    t.string   "terms"
    t.date     "published_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "job_id"
    t.text     "memo"
    t.integer  "rank"
    t.boolean  "applied"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "reviews", ["job_id"], :name => "index_reviews_on_job_id"

  create_table "terminologies", :force => true do |t|
    t.integer  "job_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "white_job_list_id"
  end

  add_index "terminologies", ["job_id"], :name => "index_terminologies_on_job_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "white_job_lists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
