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

ActiveRecord::Schema.define(version: 20170922004517) do

  create_table "User", primary_key: "email_id", id: :text, force: :cascade do |t|
    t.text "name", null: false
    t.text "password", null: false
    t.integer "type", default: 0, null: false
    t.index ["email_id"], name: "User_email_id_uindex", unique: true
    t.index ["email_id"], name: "sqlite_autoindex_User_1", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.text "email_id"
    t.text "name"
    t.text "password"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
