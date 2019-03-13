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

ActiveRecord::Schema.define(version: 2019_03_08_152305) do

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "start", null: false
    t.datetime "end"
    t.string "location"
    t.string "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.bigint "area_id"
    t.integer "state", default: 0
    t.index ["area_id"], name: "index_evaluations_on_area_id"
    t.index ["language_id", "start"], name: "index_evaluations_on_language_id_and_type_evaluation_and_start", unique: true
    t.index ["language_id"], name: "index_evaluations_on_language_id"
  end

  create_table "languages", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_languages_on_id"
  end

  create_table "records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "baucher"
    t.string "user_id", null: false
    t.bigint "evaluation_id", null: false
    t.integer "state", null: false
    t.index ["evaluation_id"], name: "index_records_on_evaluation_id"
    t.index ["user_id", "evaluation_id"], name: "index_records_on_user_id_and_evaluation_id", unique: true
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "users", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.string "phone"
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.index ["id"], name: "index_users_on_id"
  end

  add_foreign_key "evaluations", "areas", on_update: :cascade, on_delete: :cascade
  add_foreign_key "evaluations", "languages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "records", "evaluations", on_update: :cascade, on_delete: :cascade
  add_foreign_key "records", "users", on_update: :cascade, on_delete: :cascade
end
