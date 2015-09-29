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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20150929144526) do
=======
ActiveRecord::Schema.define(version: 20150928193521) do
>>>>>>> 25952218f37e0f423934da40c54dfc3e884d8fc0

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "artist"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "work_tags", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "work_tags", ["tag_id"], name: "index_work_tags_on_tag_id"
  add_index "work_tags", ["work_id"], name: "index_work_tags_on_work_id"

  create_table "works", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "img_url"
    t.string   "medium"
    t.string   "type"
<<<<<<< HEAD
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
=======
    t.float    "height"
    t.float    "width"
    t.float    "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
>>>>>>> 25952218f37e0f423934da40c54dfc3e884d8fc0
  end

  add_index "works", ["user_id"], name: "index_works_on_user_id"

end
