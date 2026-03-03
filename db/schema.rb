# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_03_03_143321) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "floors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_floors_on_user_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti", unique: true
    t.index ["user_id"], name: "index_jwt_denylists_on_user_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.string "category"
    t.text "description"
    t.boolean "available"
    t.text "image"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_menu_items_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "menu_item_id"
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.text "items"
    t.decimal "subtotal"
    t.decimal "tax"
    t.decimal "total"
    t.string "status"
    t.string "payment_method"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_type"
    t.integer "table_id"
    t.string "customer_name"
    t.integer "floor_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id"
    t.decimal "amount"
    t.string "currency"
    t.string "payment_method"
    t.string "payment_provider"
    t.string "status"
    t.string "transaction_id"
    t.datetime "processed_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "staff_members", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "email"
    t.string "phone"
    t.string "status"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "floor_id"
    t.string "number"
    t.integer "capacity"
    t.string "status"
    t.integer "order_id"
    t.string "waiter"
    t.datetime "time_seated"
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["floor_id"], name: "index_tables_on_floor_id"
    t.index ["order_id"], name: "index_tables_on_order_id"
    t.index ["user_id"], name: "index_tables_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.string "phone_number", null: false
    t.string "otp_secret_key"
    t.datetime "otp_sent_at"
    t.integer "failed_otp_attempts", default: 0
    t.datetime "otp_locked_until"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.string "name"
    t.boolean "admin", default: false
    t.boolean "phone_verified", default: false
    t.boolean "email_verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["otp_secret_key"], name: "index_users_on_otp_secret_key", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "floors", "users"
  add_foreign_key "jwt_denylists", "users"
  add_foreign_key "tables", "users"
end
