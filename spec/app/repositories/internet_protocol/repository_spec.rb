# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternetProtocol::Repository do
  subject(:create_internet_protocol) do
    described_class.create(attribute)
  end

  context 'when attribute is valid' do
    let(:attribute) { { name: Faker::Internet.ip_v4_address } }

    it 'saves internet protocol to database' do
      expect { subject }.to change { InternetProtocol.count }.by(1)
    end

    it 'calls create internet protocol' do
      expect(InternetProtocol)
        .to receive(:create!)
        .with(attribute)
        .and_call_original

      create_internet_protocol
    end
  end

  context 'when attribute is invalid' do
    context 'when ip is missing' do
      let(:attribute) { nil }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'when ip is wrong' do
      let(:attribute) { { name: '33-423-52-532' } }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
