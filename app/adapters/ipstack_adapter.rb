# frozen_string_literal: true

require 'faraday'
require 'json'

class IpstackAdapter
  WrongIpError = Class.new(StandardError)

  ACCESS_KEY = '1de96d674202e341c06139dbe054ccd3'
  DOMAIN = 'http://api.ipstack.com'

  def self.call(internet_protocol)
    fields = 'ip,continent_name,country_name,region_name,city,zip,latitude,longitude'
    url = DOMAIN + "/#{internet_protocol}"

    response = Faraday.get(url, access_key: ACCESS_KEY, fields: fields)

    @response_body = JSON.parse(response.body)

    check_for_errors

    @response_body
  end

  private

  def self.check_for_errors
    if @response_body.except('ip').values.uniq[0].nil?
      raise WrongIpError, 'Wrong IP'
    end
  end
end
