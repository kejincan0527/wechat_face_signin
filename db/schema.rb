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

ActiveRecord::Schema.define(version: 20160512154609) do

  create_table "records", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "img_path",   limit: 255
    t.boolean  "sex"
    t.integer  "age",        limit: 4
    t.boolean  "del",                    default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "scan_logs", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "record_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "scan_logs", ["record_id"], name: "index_scan_logs_on_record_id", using: :btree
  add_index "scan_logs", ["user_id"], name: "index_scan_logs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "nickname",      limit: 255
    t.integer  "sex",           limit: 2
    t.string   "avatar",        limit: 255
    t.string   "phone",         limit: 128
    t.string   "openid",        limit: 255
    t.string   "profession",    limit: 255
    t.datetime "subscribed_at"
    t.boolean  "del",                       default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_foreign_key "records", "users"
  add_foreign_key "scan_logs", "records"
  add_foreign_key "scan_logs", "users"
end
