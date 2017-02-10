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

ActiveRecord::Schema.define(version: 20170209112528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assigned_trainings", force: :cascade do |t|
    t.integer  "exercise_id"
    t.integer  "training_id"
    t.boolean  "status",      default: false
    t.date     "date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "position"
    t.index ["exercise_id"], name: "index_assigned_trainings_on_exercise_id", using: :btree
    t.index ["position"], name: "index_assigned_trainings_on_position", using: :btree
    t.index ["training_id"], name: "index_assigned_trainings_on_training_id", using: :btree
  end

  create_table "client_trainings", force: :cascade do |t|
    t.integer  "training_id"
    t.integer  "client_id"
    t.datetime "date"
    t.boolean  "status",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "title"
    t.index ["client_id"], name: "index_client_trainings_on_client_id", using: :btree
    t.index ["training_id"], name: "index_client_trainings_on_training_id", using: :btree
  end

  create_table "exercise_images", force: :cascade do |t|
    t.integer  "exercise_id"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["exercise_id"], name: "index_exercise_images_on_exercise_id", using: :btree
  end

  create_table "exercises", force: :cascade do |t|
    t.string  "title"
    t.text    "description"
    t.string  "video"
    t.string  "equipment"
    t.string  "type"
    t.integer "trainer_id"
    t.text    "remote_images"
    t.string  "focus"
    t.string  "exercise_type"
    t.index ["equipment"], name: "index_exercises_on_equipment", using: :btree
    t.index ["exercise_type"], name: "index_exercises_on_exercise_type", using: :btree
    t.index ["trainer_id"], name: "index_exercises_on_trainer_id", using: :btree
  end

  create_table "trainings", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "time"
    t.integer  "level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.integer  "trainer_id"
    t.index ["trainer_id"], name: "index_trainings_on_trainer_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.string   "image"
    t.integer  "trainer_id"
    t.string   "type"
    t.string   "address"
    t.string   "phone"
    t.text     "information"
    t.index ["admin"], name: "index_users_on_admin", using: :btree
    t.index ["trainer_id"], name: "index_users_on_trainer_id", using: :btree
    t.index ["type"], name: "index_users_on_type", using: :btree
  end

end
