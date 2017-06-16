module InseeConcern
  extend ActiveSupport::Concern

  class_methods do

    def InseeConcern.translate(longitude_s, latitude_s, dx_s, dy_s)
      r = 6371009 # Earth radius
      rad2deg = 180 / Math::PI

      longitude = longitude_s.to_f
      latitude  = latitude_s.to_f
      dx = dx_s.to_f
      dy = dy_s.to_f

      new_longitude = longitude + (dx/r) * rad2deg * (1 / Math.cos(latitude * Math::PI/180))
      new_latitude  = latitude  + (dy/r) * rad2deg

      return new_longitude, new_latitude
    end

    def InseeConcern.laea2degree(xi, yi)
      # https://epsg.io/3035
      a = 6378137.0 # demi grand axe de l'ellipsoïde
      b = 298.257222101 # demi petit axe de l'ellipsoïde
      f = 1/b # applatissement
      e = Math.sqrt((2*f)-(f**2)) # première excentricité

      longitude_origine = 10 # longitude_of_center
      latitude_origine = 52 # latitude_of_center
      lambda0 = longitude_origine * Math::PI/180
      phi1 = latitude_origine * Math::PI/180
      x0 = 4321000 # false_easting
      y0 = 3210000 # false_northing
      epsilon = 10**(-11)

      e2 = e**2

      #http://geodesie.ign.fr/contenu/fichiers/documentation/algorithmes/alg0073.pdf
      x = xi.to_f - x0
      y = yi.to_f - y0
      qp = (1-e2) * ( 1/(1-e2) - 1/(2*e) * Math.log((1-e)/(1+e)) )

      sin_phi1 = Math.sin(phi1)

      q1 = (1-e2) * ( (sin_phi1/(1-e2*sin_phi1**2)) - (1/(2*e)) * Math.log((1-e*sin_phi1)/(1+e*sin_phi1)) )
      beta1 = Math.asin(q1/qp)
      sin_beta1 = Math.sin(beta1)
      cos_beta1 = Math.cos(beta1)
      m1 = Math.cos(phi1) / Math.sqrt(1-e2*sin_phi1**2)
      rq = a * Math.sqrt(qp/2)
      d = (a*m1) / (rq*cos_beta1)
      rho = Math.sqrt((x/d)**2 + (d*y)**2)
      ce = 2 * Math.asin(rho/(2*rq))
      sin_ce = Math.sin(ce)
      cos_ce = Math.cos(ce)

      q = qp * ( (cos_ce*sin_beta1) + ((d*y*sin_ce*cos_beta1)/rho) )

      lambda = lambda0 + Math.atan( (x*sin_ce)/(d*rho*cos_beta1*cos_ce - d**2*y*sin_beta1*sin_ce) )
      phi0 = Math.asin(q/2)

      phi_iplus1 = 0
      ecart = 0

      phi_i = phi0
      begin
        phi_iplus1 = phi_i + ( (1-e2*Math.sin(phi_i)**2)**2/(2*Math.cos(phi_i))) * ( q/(1-e2) - Math.sin(phi_i)/(1-e2*Math.sin(phi_i)**2) + Math.log((1-e*Math.sin(phi_i))/(1+e*Math.sin(phi_i)))/(2*e) )
        ecart = (phi_iplus1-phi_i).abs
        phi_i = phi_iplus1
      end while ecart > epsilon
      phi = phi_i

      return lambda*(180/Math::PI), phi*(180/Math::PI)
    end
  end
end