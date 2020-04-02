class IpstackAdapter
  require 'faraday'
  require 'json'

  ACCESS_KEY = "1de96d674202e341c06139dbe054ccd3"
  DOMAIN = "http://api.ipstack.com"

  def self.call(internet_protocol)
    fields = "ip,continent_name,country_name,region_name,city,zip,latitude,longitude"
    url = DOMAIN + "/#{internet_protocol}"

    response = Faraday.get(url, {access_key: ACCESS_KEY, fields: fields})

    @response_body = JSON.parse(response.body)
  end
end
