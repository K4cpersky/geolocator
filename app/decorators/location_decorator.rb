# frozen_string_literal: true

module LocationDecorator
  class SerializableLocation < JSONAPI::Serializable::Resource
    type :locations

    attributes :continent, :country, :region, :city, :zip, :latitude, :longitude

    belongs_to :internet_protocol do
      linkage(always: true)
    end
  end
end
