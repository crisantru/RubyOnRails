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

ActiveRecord::Schema.define(version: 20141113202632) do

  create_table "articles", primary_key: "article_id", force: true do |t|
    t.string "name",        limit: 40, null: false
    t.string "patent",      limit: 15, null: false
    t.string "model",       limit: 15, null: false
    t.string "category",    limit: 20, null: false
    t.string "size",        limit: 10, null: false
    t.string "gender",      limit: 1,  null: false
    t.float  "price",       limit: 53, null: false
    t.string "description", limit: 60, null: false
  end

  create_table "articles_bills", primary_key: "articles_bills_id", force: true do |t|
    t.integer "bills_id"
    t.integer "sales_id"
  end

  add_index "articles_bills", ["bills_id"], name: "bills_id", using: :btree
  add_index "articles_bills", ["sales_id"], name: "sales_id", using: :btree

  create_table "articles_orders", primary_key: "articles_orders_id", force: true do |t|
    t.integer "total_article"
    t.float   "subtotal",      limit: 53
    t.float   "price",         limit: 53
    t.integer "article_id"
    t.integer "orders_id"
  end

  add_index "articles_orders", ["article_id"], name: "article_id", using: :btree
  add_index "articles_orders", ["orders_id"], name: "orders_id", using: :btree

  create_table "bills", primary_key: "bills_id", force: true do |t|
    t.date    "bill_date", null: false
    t.integer "client_id", null: false
    t.integer "branch_id", null: false
  end

  add_index "bills", ["branch_id"], name: "branch_id", using: :btree
  add_index "bills", ["client_id"], name: "client_id", using: :btree

  create_table "branches", primary_key: "branch_id", force: true do |t|
    t.string "name",    limit: 30,  null: false
    t.string "address", limit: 100, null: false
    t.string "state",   limit: 45
    t.string "city",    limit: 45
    t.string "phone",   limit: 15,  null: false
  end

  create_table "clients", primary_key: "client_id", force: true do |t|
    t.string "name",        limit: 60,  null: false
    t.string "rfc",         limit: 13,  null: false
    t.string "address",     limit: 100, null: false
    t.string "phone",       limit: 15,  null: false
    t.string "email",       limit: 30,  null: false
    t.string "client_type", limit: 15,  null: false
  end

  create_table "inventories", primary_key: "inventories_id", force: true do |t|
    t.integer "number_articles", null: false
    t.integer "branch_id",       null: false
    t.integer "article_id",      null: false
  end

  add_index "inventories", ["article_id"], name: "article_id", using: :btree
  add_index "inventories", ["branch_id"], name: "branch_id", using: :btree

  create_table "inventories_stocks", id: false, force: true do |t|
    t.integer "number_articles", null: false
    t.integer "stock_id",        null: false
    t.integer "article_id",      null: false
  end

  add_index "inventories_stocks", ["article_id"], name: "article_id", using: :btree
  add_index "inventories_stocks", ["stock_id"], name: "stock_id", using: :btree

  create_table "orders", primary_key: "orders_id", force: true do |t|
    t.date    "order_date",  null: false
    t.integer "stock_id",    null: false
    t.integer "staff_id",    null: false
    t.integer "provider_id", null: false
  end

  add_index "orders", ["provider_id"], name: "provider_id", using: :btree
  add_index "orders", ["staff_id"], name: "staff_id", using: :btree
  add_index "orders", ["stock_id"], name: "stock_id", using: :btree

  create_table "providers", primary_key: "provider_id", force: true do |t|
    t.string "name",    limit: 45, null: false
    t.string "address", limit: 80, null: false
    t.string "city",    limit: 20, null: false
    t.string "state",   limit: 20, null: false
    t.string "phone",   limit: 15, null: false
    t.string "mail",    limit: 30, null: false
  end

  create_table "sales", primary_key: "sales_id", force: true do |t|
    t.string  "sales_type", limit: 15, null: false
    t.date    "sales_date",            null: false
    t.integer "client_id",             null: false
    t.integer "staff_id",              null: false
  end

  add_index "sales", ["client_id"], name: "client_id", using: :btree
  add_index "sales", ["staff_id"], name: "staff_id", using: :btree

  create_table "sales_articles", primary_key: "sale_article_id", force: true do |t|
    t.float   "total_article", limit: 53
    t.float   "subtotal",      limit: 53
    t.integer "sales_id"
    t.integer "article_id"
  end

  add_index "sales_articles", ["article_id"], name: "article_id", using: :btree
  add_index "sales_articles", ["sales_id"], name: "sales_id", using: :btree

  create_table "shipments", primary_key: "shipments_id", force: true do |t|
    t.string  "status",    limit: 30, null: false
    t.integer "client_id",            null: false
    t.integer "sale_id",              null: false
  end

  add_index "shipments", ["client_id"], name: "client_id", using: :btree
  add_index "shipments", ["sale_id"], name: "sale_id", using: :btree

  create_table "shipments_articles", primary_key: "shipments_articles_id", force: true do |t|
    t.integer "shipments_id"
    t.integer "article_id"
  end

  add_index "shipments_articles", ["article_id"], name: "article_id", using: :btree
  add_index "shipments_articles", ["shipments_id"], name: "shipments_id", using: :btree

  create_table "staff_types", primary_key: "type_id", force: true do |t|
    t.float   "pay",      limit: 53
    t.string  "position", limit: 25
    t.integer "hours"
  end

  create_table "staffs", primary_key: "staff_id", force: true do |t|
    t.string  "name",      limit: 30,  null: false
    t.string  "last_name", limit: 30,  null: false
    t.string  "address",   limit: 100, null: false
    t.string  "phone",     limit: 15,  null: false
    t.string  "email",     limit: 30,  null: false
    t.integer "type_id",               null: false
    t.integer "branch_id",             null: false
  end

  add_index "staffs", ["branch_id"], name: "branch_id", using: :btree
  add_index "staffs", ["type_id"], name: "type_id", using: :btree

  create_table "stocks", primary_key: "stock_id", force: true do |t|
    t.string  "stock_type", limit: 20,  null: false
    t.string  "address",    limit: 100, null: false
    t.string  "phone",      limit: 15,  null: false
    t.integer "branch_id",              null: false
  end

  add_index "stocks", ["branch_id"], name: "branch_id", using: :btree

  create_table "users", primary_key: "user_id", force: true do |t|
    t.string  "user_name",     limit: 15,         null: false
    t.text    "password_hash", limit: 2147483647, null: false
    t.text    "password_salt", limit: 2147483647, null: false
    t.integer "staff_id",                         null: false
  end

  add_index "users", ["staff_id"], name: "staff_id", using: :btree

end
