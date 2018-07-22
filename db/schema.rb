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

ActiveRecord::Schema.define(version: 2018_07_13_164158) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_categories", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.boolean "isLeaf"
    t.bigint "catPropertyModels_id"
    t.bigint "rules_id"
    t.integer "firstLevelCatId"
    t.integer "lscSetId"
    t.boolean "variationCat"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sub_categories_id"
    t.index ["catPropertyModels_id"], name: "index_sub_categories_on_catPropertyModels_id"
    t.index ["rules_id"], name: "index_sub_categories_on_rules_id"
    t.index ["sub_categories_id"], name: "index_sub_categories_on_sub_categories_id"
  end

end
