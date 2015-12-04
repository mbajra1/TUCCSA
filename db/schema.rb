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

ActiveRecord::Schema.define(version: 20151204024931) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.text     "body",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "namespace",     limit: 255
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cs_applications", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "first_name",        limit: 255
    t.string   "middle_name",       limit: 255
    t.string   "last_name",         limit: 255
    t.string   "towson_id_number",  limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "phone",             limit: 255
    t.boolean  "is_citizen",        limit: 1
    t.string   "signed_name",       limit: 255
    t.string   "status",            limit: 255
    t.integer  "progress",          limit: 4
    t.text     "purpose_statement", limit: 65535
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "institution",       limit: 255
    t.string   "city",              limit: 255
    t.integer  "state_id",          limit: 4
    t.text     "attended_from",     limit: 65535
    t.text     "attended_to",       limit: 65535
    t.string   "degree",            limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "cs_application_id", limit: 4
  end

  create_table "mailing_addresses", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "address_line1",     limit: 255
    t.string   "address_line2",     limit: 255
    t.string   "city",              limit: 255
    t.integer  "state_id",          limit: 4
    t.integer  "zip",               limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "cs_application_id", limit: 4
  end

  create_table "purpose_statements", force: :cascade do |t|
    t.integer  "cs_application_id",    limit: 4,   null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "purpose_file_name",    limit: 255
    t.string   "purpose_content_type", limit: 255
    t.integer  "purpose_file_size",    limit: 4
    t.datetime "purpose_updated_at"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "recommendation_id", limit: 4
    t.integer  "intellect",         limit: 4
    t.integer  "leadership",        limit: 4
    t.integer  "written",           limit: 4
    t.integer  "verbal",            limit: 4
    t.integer  "reliability",       limit: 4
    t.integer  "timeliness",        limit: 4
    t.integer  "maturity",          limit: 4
    t.integer  "skill",             limit: 4
    t.integer  "commitment",        limit: 4
    t.integer  "independent",       limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.text     "notes",             limit: 65535
    t.string   "password",          limit: 255
    t.string   "status",            limit: 255,   default: "0"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer  "cs_application_id", limit: 4
    t.string   "name",              limit: 255
    t.string   "title",             limit: 255
    t.string   "email",             limit: 255
    t.datetime "time_known_from"
    t.datetime "time_known_to"
    t.string   "status",            limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transcripts", force: :cascade do |t|
    t.integer  "cs_application_id",     limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "is_admin",               limit: 1,   default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
