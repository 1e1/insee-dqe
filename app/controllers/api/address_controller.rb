class Api::AddressController < ActionController::Base
  before_action :params_query, only: [:search]

  def search
    begin
      render json: query_gouv_fr(params[:q])
    rescue
      render json: query_google(params[:q])
    end
  end

  private

  def query_gouv_fr(address)
    url = 'http://api-adresse.data.gouv.fr/search/'
    params = {
        q: address,
        limit: 1,
        autocomplete: 0,
    }

    response = RestClient.get(url, params: params)

    longitude = JsonPath.on(response, '$.features[0].geometry.coordinates[0]').first
    latitude = JsonPath.on(response, '$.features[0].geometry.coordinates[1]').first

    country = 'France'
    postcode = JsonPath.on(response, '$.features[0].properties.postcode').first
    city = JsonPath.on(response, '$.features[0].properties.city').first
    street = JsonPath.on(response, '$.features[0].properties.street').first
    number = JsonPath.on(response, '$.features[0].properties.housenumber').first

    type = JsonPath.on(response, '$.features[0].properties.type').first
    score = JsonPath.on(response, '$.features[0].properties.score').first

    raise ArgumentError, 'Argument is not an address' if 'housenumber' == type
    raise ArgumentError, 'Argument is not an accurate' if 0.75 < score

    output = {
        longitude: longitude,
        latitude: latitude,
        country: country,
        postcode: postcode,
        city: city,
        street: street,
        number: number,
    }

    return output
  end

  def query_google(address)
    url= 'https://maps.googleapis.com/maps/api/geocode/json'
    params = {
        address: address,
        key: ENV['GOOGLE_API_KEY'],
    }

    response = RestClient.get(url, params: params)

    longitude = JsonPath.on(response, '$.results[0].geometry.location.lng').first
    latitude = JsonPath.on(response, '$.results[0].geometry.location.lat').first
=begin
      country   = JsonPath.on(response, '$.results[0].address_components[?(@.types.include?("country"))].long_name').first
      postcode  = JsonPath.on(response, '$.results[0].address_components[?(@.types.include?("postal_code"))].long_name').first
      city      = JsonPath.on(response, '$.results[0].address_components[?(@.types.include?("locality"))].long_name').first
      street    = JsonPath.on(response, '$.results[0].address_components[?(@.types.include?("route"))].long_name').first
      number    = JsonPath.on(response, '$.results[0].address_components[?(@.types.include?("street_number"))].long_name').first
=end

    output = {
        longitude: longitude,
        latitude: latitude,
        #country:   country,
        #postcode:  postcode,
        #city:      city,
        #street:    street,
        #number:    number,
    }

    mapping = {
        country: 'country',
        postcode: 'postal_code',
        city: 'locality',
        street: 'route',
        number: 'street_number',
    }

    address_components = JsonPath.on(response, '$.results[0].address_components')

    address_components.first.each do |address_component|
      value = address_component['long_name']
      types = address_component['types']

      mapping.each do |key, json_type|
        if types.include?(json_type)
          output[key] = value
          break
        end
      end
    end

    return output
  end

  def params_query
    if params[:q].nil?
      render json: {error: "invalid parameters"}, status: 400
    end
  end

end
