# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    continent { "Europe" }
    country { Faker::Address.country }
    region { Faker::Address.street_name }
    city { Faker::Address.city }
    zip { Faker::Address.zip_code }
    latitue { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    internet_protocol
  end
end
