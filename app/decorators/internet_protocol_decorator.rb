# frozen_string_literal: true

module InternetProtocolDecorator
  class SerializableInternetProtocol < JSONAPI::Serializable::Resource
    type :internet_protocols

    attributes :name

    has_one :location do
      linkage(always: true)
    end
  end
end
