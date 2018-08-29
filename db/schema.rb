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

ActiveRecord::Schema.define(version: 2018_08_29_095040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.bigint "payer_id"
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.string "split_type"
    t.bigint "group_id"
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["group_id"], name: "index_bills_on_group_id"
    t.index ["payer_id"], name: "index_bills_on_payer_id"
  end

  create_table "debts", force: :cascade do |t|
    t.bigint "bill_id"
    t.bigint "borrower_id"
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.boolean "paid"
    t.index ["bill_id"], name: "index_debts_on_bill_id"
    t.index ["borrower_id"], name: "index_debts_on_borrower_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.index ["creator_id"], name: "index_groups_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "avatar"
    t.boolean "admin", default: false, null: false
    t.boolean "blocked", default: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bills", "groups"
  add_foreign_key "bills", "users", column: "payer_id"
  add_foreign_key "debts", "bills"
  add_foreign_key "debts", "users", column: "borrower_id"
end
