# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe IpstackAdapter do
  describe '.call' do
    subject(:call) { described_class.call(internet_protocol) }

    let(:internet_protocol) { '188.121.15.4' }
    let!(:access_key) { '1de96d674202e341c06139dbe054ccd3' }
    let(:url) { "http://api.ipstack.com/#{internet_protocol}" }
    let(:fields) { 'ip,continent_name,country_name,region_name,city,zip,latitude,longitude' }

    it 'calls faraday for get request' do
      expect(Faraday)
        .to receive(:get)
        .with(url, access_key: access_key, fields: fields)
        .and_call_original

      call
    end

    context 'when internet protocol is valid' do
      let(:internet_protocol) { '188.121.15.4' }
      let(:location) do
        {
          ip: '188.121.15.4',
          continent_name: 'Europe',
          country_name: 'Poland',
          region_name: 'Lower Silesia',
          city: 'Wrocław',
          zip: '53-142',
          latitude: 51.08361053466797,
          longitude: 17.001310348510742
        }
      end

      it 'returns location data' do
        expect(subject['ip']).to eq location[:ip]
        expect(subject['continent_name']).to eq location[:continent_name]
        expect(subject['country_name']).to eq location[:country_name]
        expect(subject['region_name']).to eq location[:region_name]
        expect(subject['city']).to eq location[:city]
        expect(subject['zip']).to eq location[:zip]
        expect(subject['latitude']).to eq location[:latitude]
        expect(subject['longitude']).to eq location[:longitude]
      end
    end

    context 'when internet protocol is not valid' do
      let(:internet_protocol) { '1.124.12.41.24.1' }

      it 'raises wrong ip error' do
        expect { subject }.to raise_exception IpstackAdapter::WrongIpError
      end
    end
  end
end
