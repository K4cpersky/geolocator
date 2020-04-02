# frozen_string_literal: true

class Location::Repository
  def self.create(location, internet_protocol_id)
    attributes = {
      continent: location['continent_name'],
      country: location['country_name'],
      region: location['region_name'],
      city: location['city'],
      zip: location['zip'],
      latitude: location['latitude'],
      longitude: location['longitude'],
      internet_protocol_id: internet_protocol_id
    }

    Location.create!(attributes)
  end
end
