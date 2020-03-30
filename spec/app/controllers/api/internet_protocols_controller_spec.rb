# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe Api::InternetProtocolsController, type: :controller do
  describe 'GET #show' do
    before { get :show, params: { id: internet_protocol_id } }

    let!(:location) { create(:location) }

    context 'when internet_protocol is found' do
      let(:internet_protocol_id) { location.internet_protocol_id }
      let(:response_data) { JSON.parse(response.body) }

      it { expect(response_data['data']).to have_id(internet_protocol_id.to_s) }
      it { expect(response_data['data']).to have_type('internet_protocols') }
      it {
        expect(response_data['data']).to have_attribute(:name)
          .with_value(location.internet_protocol.name)
      }
      it {
        expect(response_data['data']).to have_relationship(:location)
          .with_data('id' => location.id.to_s, 'type' => 'locations')
      }
      it {
        expect(response_data['included'])
          .to include(have_type('locations')
            .and(have_id(location.id.to_s)
            .and(have_attribute(:continent).with_value(location.continent)
            .and(have_attribute(:country).with_value(location.country)
            .and(have_attribute(:region).with_value(location.region)
            .and(have_attribute(:city).with_value(location.city)
            .and(have_attribute(:zip).with_value(location.zip)
            .and(have_attribute(:longitude).with_value(location.longitude)
            .and(have_attribute(:latitude).with_value(location.latitude))))))))))
      }
      it { expect(response.status).to eq(200) }
    end

    context 'when internet_protocol is not found' do
      let(:internet_protocol_id) { 12_345 }
      let(:response_data) { JSON.parse(response.body) }

      it {
        expect(response_data['errors'][0]['detail'])
          .to eq("Couldn't find InternetProtocol with 'id'=#{internet_protocol_id}")
      }
      it { expect(response.status).to eq(404) }
    end
  end

  describe 'callbacks' do
    it { should use_before_action(:find_internet_protocol) }
  end

  describe 'rescue_from' do
    it {
      should rescue_from(ActiveRecord::RecordNotFound)
        .with(:render_not_found_error)
    }
  end
end
