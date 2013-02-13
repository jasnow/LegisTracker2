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

ActiveRecord::Schema.define(:version => 20110313055843) do

  create_table "bill_versions", :force => true do |t|
    t.integer "number"
    t.integer "xmlid"
    t.string  "description"
    t.string  "fileid"
    t.integer "bill_id"
  end

  create_table "bills", :force => true do |t|
    t.string  "btype"
    t.integer "num"
    t.string  "suffix"
    t.integer "carryover"
    t.integer "year_id"
    t.date    "current_status_date"
    t.string  "number"
    t.string  "short_title"
    t.string  "composite_caption"
    t.text    "title"
    t.integer "house_committee_id"
    t.integer "senate_committee_id"
    t.date    "eff_date"
    t.string  "b_status"
    t.string  "status_code_id"
    t.text    "footnote"
    t.integer "code_title"
    t.integer "code_chapter"
    t.integer "bill_id"
    t.integer "xml_id"
    t.boolean "crossover",           :default => true
  end

  create_table "house_committees", :force => true do |t|
    t.string   "committee_name"
    t.string   "committee_short_name", :limit => 10
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "house_feeds", :force => true do |t|
    t.string   "title"
    t.string   "summary"
    t.string   "author"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "member_votes", :force => true do |t|
    t.integer "member_id"
    t.integer "bill_id"
    t.string  "vote_cast", :limit => 1
    t.integer "vote_id"
  end

  create_table "members", :force => true do |t|
    t.string  "last_name"
    t.string  "first_name"
    t.integer "district"
    t.string  "house",                        :limit => 1
    t.string  "party",                        :limit => 1
    t.string  "seat",                         :limit => 4
    t.string  "vote_id_string"
    t.integer "imsp_member_id"
    t.integer "total_instate_dollars"
    t.integer "total_out_of_state_dollars"
    t.integer "total_unknown_state_dollars"
    t.integer "party_committee_dollars"
    t.integer "leadership_committee_dollars"
    t.integer "candidate_money_dollars"
    t.integer "individual_dollars"
    t.integer "unitemized_donation_dollars"
    t.integer "non_contribution_dollars"
    t.integer "institution_dollars"
    t.integer "total_dollars"
    t.integer "pvs_member_id"
  end

  create_table "senate_committees", :force => true do |t|
    t.string   "committee_name"
    t.string   "committee_short_name", :limit => 10
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "senate_feeds", :force => true do |t|
    t.string   "title"
    t.string   "summary"
    t.string   "author"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "sponsorships", :force => true do |t|
    t.integer "bill_id"
    t.integer "member_id"
    t.integer "seq"
  end

  create_table "status_codes", :force => true do |t|
    t.string  "description"
    t.string  "house",       :limit => 1
    t.integer "seq"
  end

  create_table "statuses", :force => true do |t|
    t.integer  "bill_id"
    t.datetime "status_date"
    t.string   "status_code_id", :limit => 10
    t.string   "am_sub_desc"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
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

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.datetime "date"
    t.string   "description"
    t.integer  "yea"
    t.integer  "nay"
    t.integer  "not_voting"
    t.integer  "excused"
    t.integer  "bill_id"
    t.string   "branch"
    t.string   "xml_id"
    t.string   "legislation"
    t.integer  "unknown"
  end

  create_table "watched_bills", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
