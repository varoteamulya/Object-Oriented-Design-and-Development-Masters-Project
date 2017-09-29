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

ActiveRecord::Schema.define(version: 20170929145501) do

  create_table "availability_requests", force: :cascade do |t|
    t.string "email"
    t.string "license"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_checkouts", force: :cascade do |t|
    t.string "license"
    t.string "checkout_by"
    t.integer "duration"
    t.datetime "checkout_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.datetime "time_from"
    t.datetime "time_to"
  end

  create_table "car_status", force: :cascade do |t|
    t.string "status"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string "license"
    t.string "manufacturer"
    t.string "model"
    t.string "hourly"
    t.string "style"
    t.string "location"
    t.string "availability"
    t.string "checkout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_outs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checkouts", force: :cascade do |t|
    t.string "email_id"
    t.string "license"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suggestions", force: :cascade do |t|
    t.string "manufacturer"
    t.string "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_type", force: :cascade do |t|
    t.string "name"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "email_id"
    t.text "name"
    t.text "password"
    t.integer "u_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
