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

ActiveRecord::Schema[7.1].define(version: 2023_09_23_142536) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "podcast_episodes", force: :cascade do |t|
    t.bigint "podcast_id", null: false
    t.datetime "aired_at", null: false
    t.string "title", null: false
    t.text "show_notes"
    t.text "audio_file_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_podcast_episodes_on_podcast_id"
  end

  create_table "podcasts", force: :cascade do |t|
    t.text "url", null: false
    t.text "cover_art_url"
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "podcast_episodes", "podcasts"
end
