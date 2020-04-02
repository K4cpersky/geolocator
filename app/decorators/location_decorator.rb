# frozen_string_literal: true

module LocationDecorator
  class SerializableLocation < JSONAPI::Serializable::Resource
    type :locations

    attributes :continent, :country, :region, :city, :zip, :latitude, :longitude

    attribute :latitude do
      @object.latitude.round(7).to_s
    end

    attribute :longitude do
      @object.longitude.round(7).to_s
    end

    belongs_to :internet_protocol do
      linkage(always: true)
    end
  end
end
