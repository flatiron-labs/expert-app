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

ActiveRecord::Schema.define(version: 20170104172830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "busy"
    t.integer  "screen_share"
    t.string   "enjoyable"
    t.string   "productive"
    t.datetime "logged_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "self_assessment"
    t.text     "more_enjoyable"
    t.text     "more_productive"
    t.text     "help_more"
    t.text     "help_le"
    t.text     "additional_feedback"
  end

  create_table "handraise_questions", force: :cascade do |t|
    t.integer  "learn_id"
    t.datetime "asked_at"
    t.datetime "resolved_at"
    t.integer  "asked_by_learn_id"
    t.string   "asked_by_github_username"
    t.string   "asked_by_email"
    t.text     "content"
    t.integer  "track_id"
    t.integer  "batch_id"
    t.integer  "lesson_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "learn_id"
    t.string   "email"
    t.string   "github_username"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
