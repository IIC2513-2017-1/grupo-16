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

ActiveRecord::Schema.define(version: 20170514214526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "raffle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raffle_id"], name: "index_bookmarks_on_raffle_id", using: :btree
    t.index ["user_id"], name: "index_bookmarks_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "raffle_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raffle_id"], name: "index_comments_on_raffle_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "participates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "raffle_id"
    t.index ["raffle_id"], name: "index_participates_on_raffle_id", using: :btree
    t.index ["user_id"], name: "index_participates_on_user_id", using: :btree
  end

  create_table "raffles", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.string   "prize"
    t.integer  "price"
    t.datetime "finish_date"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_raffles_on_user_id", using: :btree
  end

  create_table "sorteos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "raffle_id"
    t.index ["raffle_id"], name: "index_sorteos_on_raffle_id", using: :btree
    t.index ["user_id"], name: "index_sorteos_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

  add_foreign_key "bookmarks", "raffles"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "comments", "raffles"
  add_foreign_key "comments", "users"
  add_foreign_key "participates", "raffles"
  add_foreign_key "participates", "users"
  add_foreign_key "raffles", "users"
  add_foreign_key "sorteos", "raffles"
  add_foreign_key "sorteos", "users"
end
