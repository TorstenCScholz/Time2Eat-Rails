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

ActiveRecord::Schema.define(version: 20170801175132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "polls", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "status"
    t.datetime "started_at"
    t.datetime "concluded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.bigint "poll_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_proposals_on_item_id"
    t.index ["poll_id"], name: "index_proposals_on_poll_id"
  end

  create_table "voters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_voters_on_name", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "proposal_id"
    t.bigint "voter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "preference", limit: 40
    t.index ["proposal_id", "voter_id"], name: "index_votes_on_proposal_id_and_voter_id", unique: true
    t.index ["proposal_id"], name: "index_votes_on_proposal_id"
    t.index ["voter_id"], name: "index_votes_on_voter_id"
  end

  add_foreign_key "proposals", "items"
  add_foreign_key "proposals", "polls"
  add_foreign_key "votes", "proposals"
  add_foreign_key "votes", "voters"
end
