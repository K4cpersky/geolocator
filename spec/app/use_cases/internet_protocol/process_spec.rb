# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe InternetProtocol::Process do
  describe '.call' do
    subject(:call) { described_class.call(params) }

    let(:name) { "188.121.15.4" }
    let(:params) do
      { name: name }
    end
    let(:location_attributes) do
      {
        "city"=>"Wrocław",
        "continent_name"=>"Europe",
        "country_name"=>"Poland",
        "ip"=>"188.121.15.4",
        "latitude"=>51.08361053466797,
        "longitude"=>17.001310348510742,
        "region_name"=>"Lower Silesia",
        "zip"=>"53-142"
      }
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

    let(:ip) { double :internet_protocol }

    it 'calls location repository' do
      binding.pry

      expect(Location::Repository)
        .to receive(:create)
        .with(location_attributes, internet_protocol.id)
        .and_call_original

      call
    end

    # it 'returns payment data' do
    #   call
    #   expect(call.new_payment.paid_amount).to eq payment_params[:paid_amount]
    #   expect(call.new_payment.user_id).to eq user.id
    #   expect(call.new_payment.event_id).to eq event.id
    #   expect(call.new_payment.currency).to eq payment_params[:currency]
    #   expect(call.new_payment.tickets_ordered_amount)
    #     .to eq payment_params[:tickets_ordered_amount]
    # end
  end
end
