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

      it { binding.pry }
      # TODO: Describe attributes
      it { expect(response.status).to eq(200) }
    end

    context 'when internet_protocol is not found' do
      let(:internet_protocol_id) { 12_345 }
      let(:response_data) { JSON.parse(response.body) }

      it { expect(response_data["errors"][0]["detail"]).to eq("Couldn't find InternetProtocol with 'id'=#{internet_protocol_id}") }
      it { expect(response.status).to eq(404) }
    end
  end

  describe 'callbacks' do
    it { should use_before_action(:find_internet_protocol) }
  end

  describe 'rescue_from' do
    it { should rescue_from(ActiveRecord::RecordNotFound).with(:render_not_found_error) }
  end
end
