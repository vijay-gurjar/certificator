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

ActiveRecord::Schema[7.0].define(version: 2023_06_14_222109) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "zila"
    t.string "lok_sabha"
    t.string "state"
    t.date "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_certificates_on_user_id"
  end

  create_table "downloads", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "certificate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["certificate_id"], name: "index_downloads_on_certificate_id"
    t.index ["user_id"], name: "index_downloads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "phone_number"
    t.string "otp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "otp_created_at"
  end

  add_foreign_key "certificates", "users"
  add_foreign_key "downloads", "certificates"
  add_foreign_key "downloads", "users"
end
