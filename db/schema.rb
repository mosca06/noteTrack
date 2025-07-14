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

ActiveRecord::Schema[7.2].define(version: 2025_07_14_092624) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "sector"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "handovers", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "notebook_id", null: false
    t.integer "start_state", null: false
    t.integer "final_state"
    t.datetime "start_date", null: false
    t.datetime "final_date"
    t.text "cause"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_handovers_on_client_id"
    t.index ["notebook_id"], name: "index_handovers_on_notebook_id"
  end

  create_table "notebooks", force: :cascade do |t|
    t.string "brand", null: false
    t.string "model", null: false
    t.string "asset_number", null: false
    t.string "serial_number", null: false
    t.string "equipment_id", null: false
    t.date "purchase_date", null: false
    t.date "manufacture_date"
    t.text "description"
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_number"], name: "index_notebooks_on_asset_number", unique: true
    t.index ["equipment_id"], name: "index_notebooks_on_equipment_id", unique: true
    t.index ["serial_number"], name: "index_notebooks_on_serial_number", unique: true
  end

  add_foreign_key "handovers", "clients"
  add_foreign_key "handovers", "notebooks"
end
