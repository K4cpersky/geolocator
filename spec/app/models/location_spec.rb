# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    subject(:location) { create(:location) }

    it { is_expected.to validate_presence_of(:continent) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:region) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:internet_protocol) }
  end
end
