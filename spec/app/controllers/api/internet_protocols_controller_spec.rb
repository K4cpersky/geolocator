# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe Api::InternetProtocolsController, type: :controller do
  describe 'GET #show' do
    before { get :show, params: { id: internet_protocol_id } }

    let!(:location) { create(:location) }
    let(:response_data) { JSON.parse(response.body) }

    context 'when internet_protocol is found' do
      let(:internet_protocol_id) { location.internet_protocol_id }

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
            .and(have_attribute(:longitude).with_value(location.longitude.round(7).to_s)
            .and(have_attribute(:latitude).with_value(location.latitude.round(7).to_s))))))))))
      }
      it { expect(response.status).to eq(200) }
    end

    context 'when internet_protocol is not found' do
      let(:internet_protocol_id) { 12_345 }

      it {
        expect(response_data['errors'][0]['detail'])
          .to eq("Couldn't find InternetProtocol with 'id'=#{internet_protocol_id}")
      }
      it { expect(response.status).to eq(404) }
    end
  end

  describe 'GET #index' do
    let(:response_data) { JSON.parse(response.body) }

    context 'when internet protocols exist' do
      let!(:locations) { create_list(:location, 10) }

      it 'returns internet_protocols' do
        get :index

        expect(response_data['data'].length).to eq 10
      end
      it 'has status 200' do
        get :index

        expect(response.status).to eq(200)
      end
      it 'contains valid response data' do
        get :index

        expect(response_data['data'][0]).to have_id(locations.first.internet_protocol_id.to_s)
        expect(response_data['data'][0]).to have_type('internet_protocols')
        expect(response_data['data'][0]).to have_attribute(:name)
          .with_value(locations.first.internet_protocol.name)
        expect(response_data['data'][0]).to have_relationship(:location)
          .with_data('id' => locations.first.id.to_s, 'type' => 'locations')
      end
    end

    context 'when there is no internet protocol' do
      it 'does not return any internet_protocol' do
        get :index

        expect(response_data['data'].length).to eq 0
      end
      it 'has status 200' do
        get :index

        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET #destroy' do
    subject(:internet_protocol_delete) do
      delete :destroy, params: { id: internet_protocol_id }
    end

    let!(:location) { create(:location) }

    context 'when internet_protocol is found' do
      let(:internet_protocol_id) { location.internet_protocol.id }

      it 'destroys internet protocol' do
        expect { internet_protocol_delete }.to change { InternetProtocol.count }.by(-1)
      end
      it 'destroys internet protocol location' do
        expect { internet_protocol_delete }.to change { Location.count }.by(-1)
      end
      it { expect(response.body).to eq '' }
      it { expect(response.status).to eq(200) }
    end

    context 'when internet_protocol is not found' do
      let(:internet_protocol_id) { 123_456 }
      let(:response_data) { JSON.parse(response.body) }

      it {
        internet_protocol_delete
        expect(response_data['errors'][0]['detail'])
          .to eq("Couldn't find InternetProtocol with 'id'=#{internet_protocol_id}")
      }
      it {
        internet_protocol_delete
        expect(response.status).to eq(404)
      }
    end
  end

  describe 'POST #create' do
    subject(:post_create) do
      post :create, params: params, as: :json
    end

    let(:params) do
      {
        data: {
          attributes: {
            name: internet_protocol_name
          }
        }
      }
    end
    let(:response_data) do
      JSON.parse(response.body)
    end

    context 'when internet protocol is created' do
      let(:internet_protocol_name) { '134.201.250.155' }

      around do |example|
        VCR.use_cassette('IpstackAdapter::Call_controller_success') do
          example.run
        end
      end

      it 'runs internet protocol process' do
        ActionController::Parameters.permit_all_parameters = true
        permitted_params = ActionController::Parameters.new(name: internet_protocol_name)
        expect(InternetProtocol::Process)
          .to receive(:call).with(permitted_params)
                            .and_call_original

        post_create
      end

      let(:internet_protocol_name) { '188.121.15.4' }
      let(:location) do
        {
          city: 'Wrocław',
          continent: 'Europe',
          country: 'Poland',
          ip: '188.121.15.4',
          latitude: 51.08361053466797,
          longitude: 17.001310348510742,
          region: 'Lower Silesia',
          zip: '53-142'
        }
      end

      it 'contains valid response data' do
        post :create, params: params, as: :json

        expect(response.status).to eq(200)
        expect(response_data['data']).to have_id(InternetProtocol.first.id.to_s)
        expect(response_data['data']).to have_type('internet_protocols')
        expect(response_data['data'])
          .to have_attribute(:name).with_value(internet_protocol_name)
        expect(response_data['data']).to have_relationship(:location)
          .with_data('id' => Location.first.id.to_s, 'type' => 'locations')
        expect(response_data['included'])
          .to include(have_type('locations')
            .and(have_id(Location.first.id.to_s)
            .and(have_attribute(:continent).with_value(location[:continent])
            .and(have_attribute(:country).with_value(location[:country])
            .and(have_attribute(:region).with_value(location[:region])
            .and(have_attribute(:city).with_value(location[:city])
            .and(have_attribute(:zip).with_value(location[:zip])
            .and(have_attribute(:longitude).with_value(location[:longitude].round(7).to_s)
            .and(have_attribute(:latitude).with_value(location[:latitude].round(7).to_s))))))))))
      end
    end

    context 'when internet protocol is not created' do
      context 'when internet protocol is invalid' do
        let(:internet_protocol_name) { '123-456-123' }

        it {
          post :create, params: params, as: :json

          expect(response_data['errors'][0]['detail'])
            .to eq('Validation failed: Name is invalid')
        }
        it {
          post :create, params: params, as: :json

          expect(response.status).to eq(422)
        }
      end

      context 'when internet protocol is already created' do
        let(:internet_protocol_name) { '134.201.250.155' }
        let!(:internet_protocol) do
          create(:internet_protocol, name: '134.201.250.155')
        end

        it {
          post :create, params: params, as: :json

          expect(response_data['errors'][0]['detail'])
            .to eq('Validation failed: Name has already been taken')
        }
        it {
          post :create, params: params, as: :json

          expect(response.status).to eq(422)
        }
      end
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
    it {
      should rescue_from(ActiveRecord::RecordInvalid)
        .with(:render_not_valid_error)
    }
    it {
      should rescue_from(IpstackAdapter::WrongIpError)
        .with(:render_wrong_ip)
    }
  end
end
