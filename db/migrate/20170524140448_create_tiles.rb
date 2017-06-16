class CreateTiles < ActiveRecord::Migration[5.0]
  def change
    create_table :tiles, id: false do |t|
      t.string :id
      t.string :idINSPIRE
      t.string :idk
      t.integer :ind_c
      t.integer :nbcar

      t.float :longitude_min
      t.float :latitude_min
      t.float :longitude_max
      t.float :latitude_max

      t.timestamps

      t.index :id, unique: true
      t.index :idINSPIRE, unique: true
    end
  end
end
