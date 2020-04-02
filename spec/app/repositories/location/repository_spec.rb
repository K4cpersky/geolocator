# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location::Repository do
  subject(:create_location) do
    described_class.create(location, internet_protocol_id)
  end

  let!(:internet_protocol_id) { create(:internet_protocol).id }

  let(:location) do
    {
      "continent_name"=>"Europe",
      "country_name"=>country,
      "region_name"=>"Lower Silesia",
      "city"=>Faker::Address.city,
      "zip"=>Faker::Address.zip_code,
      "latitude"=>Faker::Address.latitude,
      "longitude"=>Faker::Address.longitude
    }
  end
  let(:attributes) do
    {
      continent: location["continent_name"],
      country: location["country_name"],
      region: location["region_name"],
      city: location["city"],
      zip: location["zip"],
      latitude: location["latitude"],
      longitude: location["longitude"],
      internet_protocol_id: internet_protocol_id
    }
  end

  context 'when attributes are valid' do
    let(:country) { Faker::Address.country }

    it 'saves location to database' do
      expect { subject }.to change { Location.count }.by(1)
    end

    it 'calls create location' do
      expect(Location)
        .to receive(:create!)
        .with(attributes)
        .and_call_original

      create_location
    end
  end

  context 'when attributes are not invalid' do
    context 'when country is missing' do
      let(:country) { nil }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
