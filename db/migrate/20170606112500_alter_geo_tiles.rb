class AlterGeoTiles < ActiveRecord::Migration[5.1]

  def change
    # enable_extension :postgis

    change_table :tiles do |t|
      t.st_polygon :shape, geographic: true, srid: 4326

      t.index :shape, using: :gist #, spatial: true
    end

    factory = RGeo::Geographic.spherical_factory(srid: 4326)

    Tile.find_each do |tile|
      top_right   = factory.point(tile.longitude_max, tile.latitude_max)
      bottom_right = factory.point(tile.longitude_max, tile.latitude_min)
      bottom_left = factory.point(tile.longitude_min, tile.latitude_min)
      top_left   = factory.point(tile.longitude_min, tile.latitude_max)

      lines = factory.line_string([top_right, bottom_right, bottom_left, top_left])

      tile.shape = factory.st_polygon(lines)
      tile.save!
    end
  end
end
