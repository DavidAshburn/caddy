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

ActiveRecord::Schema[7.0].define(version: 2022_11_05_183812) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer "score"
    t.string "shots", null: false
    t.integer "length"
    t.integer "tee"
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pars"
    t.index ["course_id"], name: "index_cards_on_course_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "coursekeys", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_coursekeys_on_course_id"
    t.index ["user_id"], name: "index_coursekeys_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "course_id"
    t.string "name"
    t.string "holes"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.string "reviews"
    t.string "rating"
    t.string "private"
    t.string "paytoplay"
    t.string "tee_1_clr"
    t.string "tee_2_clr"
    t.string "tee_3_clr"
    t.string "tee_4_clr"
    t.string "dgcr_url"
    t.string "dgcr_mobile_url"
    t.string "rating_img"
    t.string "rating_img_small"
    t.string "photo_thumb"
    t.string "photo_medium"
    t.string "photo_hole"
    t.string "photo_cap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "latitude"
    t.string "longitude"
    t.string "street_addr"
    t.integer "creator"
  end

  create_table "disckeys", force: :cascade do |t|
    t.bigint "disc_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disc_id"], name: "index_disckeys_on_disc_id"
    t.index ["user_id"], name: "index_disckeys_on_user_id"
  end

  create_table "discs", force: :cascade do |t|
    t.string "maker"
    t.string "model"
    t.float "weight"
    t.float "diameter"
    t.float "height"
    t.float "depth"
    t.float "rimdiameter"
    t.float "rimthickness"
    t.float "rimratio"
    t.float "rimconfig"
    t.float "flex"
    t.float "speed"
    t.float "glide"
    t.float "turn"
    t.float "fade"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_discs_on_user_id"
  end

  create_table "holepins", force: :cascade do |t|
    t.integer "hole_num"
    t.string "hole_lbl"
    t.integer "tee_1_len"
    t.integer "tee_2_len"
    t.integer "tee_3_len"
    t.integer "tee_4_len"
    t.integer "tee_1_par"
    t.integer "tee_2_par"
    t.integer "tee_3_par"
    t.integer "tee_4_par"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_holepins_on_course_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "coursekeys", "courses"
  add_foreign_key "coursekeys", "users"
  add_foreign_key "disckeys", "discs"
  add_foreign_key "disckeys", "users"
end
