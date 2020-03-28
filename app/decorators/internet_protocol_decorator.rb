module InternetProtocolDecorator
  class SerializableBase < JSONAPI::Serializable::Resource
    type :internet_protocols

    attributes :name

    has_one :location do
      linkage( always: true )
    end
  end

  class Show < SerializableBase
  end
end
