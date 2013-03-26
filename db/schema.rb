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

ActiveRecord::Schema.define(:version => 20130326005924) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cs_applications", :force => true do |t|
    t.integer  "user_id"
    t.string   "first"
    t.string   "middle"
    t.string   "last"
    t.integer  "tuid"
    t.string   "email"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "telephone"
    t.boolean  "is_citizen"
    t.string   "signed_name"
    t.integer  "status"
    t.integer  "progress"
    t.text     "purpose_statement"
    t.string   "purpose_file_name"
    t.string   "purpose_content_type"
    t.integer  "purpose_file_size"
    t.datetime "purpose_updated_at"
  end

  create_table "institutions", :force => true do |t|
    t.string   "institution"
    t.string   "city"
    t.integer  "state_id"
    t.text     "attended_from"
    t.text     "attended_to"
    t.string   "degree"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "cs_application_id"
  end

  create_table "mailing_addresses", :force => true do |t|
    t.string   "name"
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.integer  "state_id"
    t.integer  "zip"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "cs_application_id"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "recommendation_id"
    t.integer  "intellect"
    t.integer  "leadership"
    t.integer  "written"
    t.integer  "verbal"
    t.integer  "reliability"
    t.integer  "timeliness"
    t.integer  "maturity"
    t.integer  "skill"
    t.integer  "commitment"
    t.integer  "independent"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "notes"
  end

  create_table "recommendations", :force => true do |t|
    t.integer  "cs_application_id"
    t.string   "name"
    t.string   "title"
    t.string   "email"
    t.datetime "time_known_from"
    t.datetime "time_known_to"
    t.integer  "status"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transcripts", :force => true do |t|
    t.integer  "cs_application_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "is_admin",               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
