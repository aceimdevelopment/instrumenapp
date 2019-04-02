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

ActiveRecord::Schema.define(version: 2019_04_01_214617) do

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type", null: false
    t.string "title"
    t.date "start", null: false
    t.string "location"
    t.bigint "schedule_id"
    t.string "cost"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_evaluations_on_schedule_id"
  end

  create_table "general_parameters", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "value", null: false
    t.index ["id"], name: "index_general_parameters_on_id"
  end

  create_table "inscriptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "score", default: 0
    t.string "baucher"
    t.integer "status", default: 0
    t.integer "evatype", null: false
    t.string "language_id", null: false
    t.bigint "area_id"
    t.string "user_id", null: false
    t.bigint "evaluation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_inscriptions_on_area_id"
    t.index ["evaluation_id"], name: "index_inscriptions_on_evaluation_id"
    t.index ["language_id", "area_id", "user_id", "evatype"], name: "uq_language_area_user_evatype", unique: true
    t.index ["language_id"], name: "index_inscriptions_on_language_id"
    t.index ["user_id"], name: "index_inscriptions_on_user_id"
  end

  create_table "languages", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_languages_on_id"
  end

  create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.integer "evatype", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "evaluations", "schedules", on_update: :cascade, on_delete: :cascade
  add_foreign_key "inscriptions", "areas", name: "inscriptions_ibfk_4", on_update: :cascade, on_delete: :cascade
  add_foreign_key "inscriptions", "evaluations", name: "inscriptions_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "inscriptions", "languages", name: "inscriptions_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "inscriptions", "users", name: "inscriptions_ibfk_2", on_update: :cascade, on_delete: :cascade
end
