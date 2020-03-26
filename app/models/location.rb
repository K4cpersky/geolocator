# frozen_string_literal: true

class Location < ApplicationRecord
  validates :continent, presence: true
  validates :country, presence: true
  validates :region, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :latitue, presence: true
  validates :longitude, presence: true

  belongs_to :internet_protocol
end
