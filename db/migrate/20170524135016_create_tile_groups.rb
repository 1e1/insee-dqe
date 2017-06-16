class CreateTileGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :tile_groups, id: false do |t|
      t.string :idk
      t.integer :men
      t.integer :men_surf
      t.integer :men_occ5
      t.integer :men_coll
      t.integer :men_5ind
      t.integer :men_1ind
      t.integer :i_1ind
      t.integer :men_prop
      t.integer :i_prop
      t.integer :men_basr
      t.integer :i_basr
      t.integer :ind_r
      t.integer :ind_age1
      t.integer :ind_age2
      t.integer :ind_age3
      t.integer :ind_age4
      t.integer :ind_age5
      t.integer :ind_age6
      t.integer :ind_age7
      t.integer :i_age7
      t.integer :ind_age8
      t.integer :i_age8
      t.integer :ind_srf
      t.integer :nbcar

      t.timestamps

      t.index :idk, unique: true
    end
  end
end
