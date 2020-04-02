# frozen_string_literal: true

class InternetProtocol::Process
  def self.call(params)
    @internet_protocol = InternetProtocol::Repository.create(params)

    @location = IpstackAdapter.call(@internet_protocol.name)

    Location::Repository.create(@location, @internet_protocol.id)

    @internet_protocol
  end
end
