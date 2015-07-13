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

ActiveRecord::Schema.define(version: 20150713022439) do

  create_table "cart_details", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "product_id", limit: 4, null: false
    t.integer  "price",      limit: 4, null: false
    t.integer  "quantity",   limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "cart_details", ["product_id", "created_at"], name: "index_cart_details_on_product_id_and_created_at", using: :btree
  add_index "cart_details", ["user_id", "product_id"], name: "index_cart_details_on_user_id_and_product_id", unique: true, using: :btree

  create_table "commonly_used_destinations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "name",       limit: 255, null: false
    t.string   "address",    limit: 255, null: false
    t.integer  "phone",      limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "commonly_used_destinations", ["user_id"], name: "index_commonly_used_destinations_on_user_id", using: :btree

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id",   limit: 4, null: false
    t.integer  "product_id", limit: 4, null: false
    t.integer  "price",      limit: 4, null: false
    t.integer  "quantity",   limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "order_details", ["order_id", "product_id"], name: "index_order_details_on_order_id_and_product_id", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "name",       limit: 255, null: false
    t.string   "address",    limit: 255, null: false
    t.integer  "phone",      limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "picture",    limit: 255, null: false
    t.integer  "price",      limit: 4,   null: false
    t.integer  "stock",      limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
    t.string   "remember_token",  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
