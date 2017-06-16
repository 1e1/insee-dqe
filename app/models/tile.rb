class Tile < ApplicationRecord
  self.primary_key = :id

  belongs_to :tile_group, foreign_key: 'idk'

  include InseeConcern

  scope :containing, -> (point) { where("tiles.shape && ?", point) }

  before_save do
    compute_coordinates
    compute_shape
  end

  def compute_coordinates
    # CRS3035RES200mN2030000E4254200
    size, y_min, x_min = self.idINSPIRE.scan(/CRS3035RES(\d+)mN(\d+)E(\d+)$/).first

    self.longitude_min, self.latitude_min = InseeConcern.laea2degree(x_min, y_min)
    self.longitude_max, self.latitude_max = InseeConcern.translate(self.longitude_min, self.latitude_min, size, size)
  end

  def compute_shape
    factory = RGeo::Geographic.spherical_factory(srid: 4326)

    top_right   = factory.point(self.longitude_max, self.latitude_max)
    bottom_right = factory.point(self.longitude_max, self.latitude_min)
    bottom_left = factory.point(self.longitude_min, self.latitude_min)
    top_left   = factory.point(self.longitude_min, self.latitude_max)

    lines = factory.line_string([top_right, bottom_right, bottom_left, top_left])

    self.shape = factory.polygon(lines)

    pp self
  end
end
