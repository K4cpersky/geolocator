# frozen_string_literal: true

require 'resolv'

class InternetProtocol < ApplicationRecord
  validates :name, presence: true, uniqueness: true, case_sensitive: false,
                   format: { with: Resolv::AddressRegex }

  has_one :location, dependent: :destroy
end
