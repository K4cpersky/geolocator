# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe IpstackAdapter do
  describe '.call' do
    subject(:call) { described_class.call(internet_protocol) }

    let(:internet_protocol) { '188.121.15.4' }

    it { subject }
  end
end
