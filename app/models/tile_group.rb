class TileGroup < ApplicationRecord
  self.primary_key = :idk

  has_many :tile, foreign_key: 'idk'
end
