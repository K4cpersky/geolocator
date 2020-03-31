# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternetProtocol::Repository do
  subject(:create_internet_protocol) do
    described_class.create( params )
  end

  let(:params) do
    { name: internet_protocol }
  end

  context 'when data is valid' do
    let(:internet_protocol) { "66.249.69.123" }

    it 'saves internet protocol to database' do
      expect { subject }.to change { InternetProtocol.count }.by(1)
    end

    it 'calls create internet protocol' do
      expect(InternetProtocol)
        .to receive(:create!)
        .with(
          name: internet_protocol,
        )
        .and_call_original

      create_internet_protocol
    end
  end

  context 'when data is invalid' do
    context 'when ip is missing' do
      let(:internet_protocol) { nil }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    # context 'when ip is wrong' do
    #   let(:internet_protocol) { "33-423-52-532" }
    #
    #   it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    # end
  end
end
