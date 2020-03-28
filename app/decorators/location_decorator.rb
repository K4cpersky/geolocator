module LocationDecorator
  class SerializableBase < JSONAPI::Serializable::Resource
    type :locations

    attributes :continent, :country, :region, :city, :zip, :latitue, :longitude

    belongs_to :internet_protocol do
      linkage( always: true )
    end
  end

  class Show < SerializableBase
  end
end
