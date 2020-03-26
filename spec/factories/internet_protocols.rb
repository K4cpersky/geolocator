# frozen_string_literal: true

FactoryBot.define do
  factory :internet_protocol do
    name { Faker::Internet.ip_v4_address }
  end
end
