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

ActiveRecord::Schema.define(version: 20170606112500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_topology"
  enable_extension "fuzzystrmatch"
  enable_extension "postgis_tiger_geocoder"
  enable_extension "uuid-ossp"

  create_table "tile_groups", id: false, force: :cascade do |t|
    t.string "idk"
    t.integer "men"
    t.integer "men_surf"
    t.integer "men_occ5"
    t.integer "men_coll"
    t.integer "men_5ind"
    t.integer "men_1ind"
    t.integer "i_1ind"
    t.integer "men_prop"
    t.integer "i_prop"
    t.integer "men_basr"
    t.integer "i_basr"
    t.integer "ind_r"
    t.integer "ind_age1"
    t.integer "ind_age2"
    t.integer "ind_age3"
    t.integer "ind_age4"
    t.integer "ind_age5"
    t.integer "ind_age6"
    t.integer "ind_age7"
    t.integer "i_age7"
    t.integer "ind_age8"
    t.integer "i_age8"
    t.integer "ind_srf"
    t.integer "nbcar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idk"], name: "index_tile_groups_on_idk", unique: true
  end

  create_table "tiles", id: false, force: :cascade do |t|
    t.string "id"
    t.string "idINSPIRE"
    t.string "idk"
    t.integer "ind_c"
    t.integer "nbcar"
    t.float "longitude_min"
    t.float "latitude_min"
    t.float "longitude_max"
    t.float "latitude_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geography "shape", limit: {:srid=>4326, :type=>"st_polygon", :geographic=>true}
    t.index ["id"], name: "index_tiles_on_id", unique: true
    t.index ["idINSPIRE"], name: "index_tiles_on_idINSPIRE", unique: true
    t.index ["shape"], name: "index_tiles_on_shape", using: :gist
  end

end
