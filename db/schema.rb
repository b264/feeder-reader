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

ActiveRecord::Schema.define(:version => 20141017094316) do

  create_table "channels", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.string   "description"
    t.string   "language"
    t.string   "copyright"
    t.string   "managingEditor"
    t.string   "webMaster"
    t.date     "pubDate"
    t.date     "lastBuildDate"
    t.integer  "category_id"
    t.string   "generator"
    t.string   "docs"
    t.integer  "cloud_id"
    t.integer  "ttl"
    t.integer  "image_id"
    t.string   "textInput"
    t.integer  "skipHours_id"
    t.integer  "skipDays_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "URL"
  end

end