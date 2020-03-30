# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternetProtocol, type: :model do
  describe 'validations' do
    subject(:internet_protocol) { create(:internet_protocol) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'relations' do
    it { is_expected.to have_one(:location).dependent(:destroy) }
  end
end
