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

ActiveRecord::Schema.define(version: 20170525213632) do

  create_table "charges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tasker_id"
    t.decimal  "amount"
    t.string   "stripe_customer_id"
    t.string   "destination_stripe_account_id"
    t.decimal  "service_fee"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "markets", force: :cascade do |t|
    t.string   "display_name"
    t.string   "url_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "service_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "tasker_id"
    t.integer  "parent_category_id"
  end

  create_table "service_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "service_category_id"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.text     "additional_information"
    t.datetime "scheduled_date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "time_of_day"
    t.date     "scheduled_day"
    t.integer  "tasker_id"
    t.boolean  "is_complete_tasker"
    t.boolean  "is_complete_user"
    t.string   "city"
    t.boolean  "is_live"
    t.text     "description"
    t.decimal  "price"
    t.string   "stripe_customer_id"
    t.boolean  "charge_approved"
    t.datetime "tasker_completion_time"
    t.string   "contact_phone_number"
    t.decimal  "tasker_hourly_rate"
    t.decimal  "hours_reported_by_tasker"
    t.boolean  "is_cancelled"
  end

  create_table "user_service_categories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "service_category_id"
    t.text     "description"
    t.decimal  "hourly_rate"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "user_stripe_customers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_customer_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "default_payment"
    t.boolean  "hidden_from_user"
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
    t.string   "first_name"
    t.string   "last_name"
    t.text     "phone_number"
    t.text     "zip_code"
    t.boolean  "is_tasker"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "last_seen_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "address"
    t.string   "stripe_account_id"
    t.string   "stripe_secret_key"
    t.string   "stripe_publishable_key"
    t.boolean  "is_admin"
    t.string   "contact_phone_number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
