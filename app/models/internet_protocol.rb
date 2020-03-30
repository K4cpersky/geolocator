# frozen_string_literal: true

class InternetProtocol < ApplicationRecord
  validates :name, presence: true, uniqueness: true, case_sensitive: false

  has_one :location, dependent: :destroy
end
