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

ActiveRecord::Schema.define(version: 20150319164052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "job_categories", force: true do |t|
    t.string   "name"
    t.integer  "tasks_id"
    t.boolean  "user_generated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_url"
  end

  add_index "job_categories", ["tasks_id"], name: "index_job_categories_on_tasks_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "subject"
    t.text     "body"
    t.integer  "task_id"
    t.integer  "proposed_price"
    t.integer  "wallet_price"
    t.string   "message_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "unread",         default: true
    t.boolean  "deleted",        default: false
  end

  create_table "notes", force: true do |t|
    t.integer  "task_id"
    t.text     "body"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "status",       default: "unread"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["task_id"], name: "index_notes_on_task_id", using: :btree

  create_table "offers", force: true do |t|
    t.string   "subject"
    t.integer  "task_id"
    t.integer  "user_id"
    t.decimal  "proposed_price"
    t.string   "body"
    t.string   "status"
    t.boolean  "unread",         default: true
    t.boolean  "deleted",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "active",         default: true
  end

  add_index "offers", ["task_id"], name: "index_offers_on_task_id", using: :btree
  add_index "offers", ["user_id"], name: "index_offers_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.text     "body"
    t.integer  "score"
    t.integer  "poster_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["task_id"], name: "index_reviews_on_task_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "task_date"
    t.text     "subject"
    t.text     "description"
    t.text     "deliverables"
    t.datetime "duration"
    t.decimal  "price",               precision: 10, scale: 0
    t.datetime "due_date"
    t.integer  "zipcode"
    t.integer  "rating_required"
    t.integer  "no_ratings_required"
    t.integer  "final_rating"
    t.string   "final_review"
    t.string   "status",                                       default: "open"
    t.string   "task_type",                                    default: "bid"
    t.integer  "wallet_id"
    t.integer  "runner_id"
    t.string   "task_category"
    t.integer  "views"
    t.integer  "job_category_id"
    t.boolean  "local",                                        default: true
    t.text     "todolist",                                     default: [],     array: true
  end

  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "todoitems", force: true do |t|
    t.text     "body"
    t.boolean  "completed",  default: false
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "todoitems", ["task_id"], name: "index_todoitems_on_task_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                                 default: "",                   null: false
    t.string   "encrypted_password",                                    default: "",                   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                         default: 0,                    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                                                 default: false
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "phone",                        precision: 10, scale: 0
    t.text     "about_me"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "image_url",                                             default: "/assets/avatar.jpg"
    t.string   "username"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
