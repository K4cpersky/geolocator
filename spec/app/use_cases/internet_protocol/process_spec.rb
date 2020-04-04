# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe InternetProtocol::Process do
  describe '.call' do
    subject(:call) { described_class.call(params) }

    let(:name) { '188.121.15.4' }
    let(:params) do
      { name: name }
    end
    let(:location_attributes) do
      {
        'city' => 'Wrocław',
        'continent_name' => 'Europe',
        'country_name' => 'Poland',
        'ip' => '188.121.15.4',
        'latitude' => 51.08361053466797,
        'longitude' => 17.001310348510742,
        'region_name' => 'Lower Silesia',
        'zip' => '53-142'
      }
    end

    around do |example|
      VCR.use_cassette('IpstackAdapter::Call_process') do
        example.run
      end
    end

    it 'calls internet protocol repository' do
      expect(InternetProtocol::Repository)
        .to receive(:create)
        .with(params)
        .and_call_original

      call
    end

    it 'calls ipstack adapter' do
      expect(IpstackAdapter)
        .to receive(:call)
        .with(name)
        .and_call_original

      call
    end
  end
end
