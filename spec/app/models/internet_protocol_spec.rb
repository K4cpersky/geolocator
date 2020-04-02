# frozen_string_literal: true

require 'rails_helper'
require 'resolv'

RSpec.describe InternetProtocol, type: :model do
  describe 'validations' do
    subject(:internet_protocol) { create(:internet_protocol) }
    let(:ip) { internet_protocol.name }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it 'internet protocol should have valid format' do
      expect(ip).to match(Resolv::AddressRegex)
    end
  end

  describe 'relations' do
    it { is_expected.to have_one(:location).dependent(:destroy) }
  end
end
