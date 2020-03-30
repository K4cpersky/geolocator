# frozen_string_literal: true

class AddIndexesToLocations < ActiveRecord::Migration[6.0]
  def change
    add_index :locations, :continent
    add_index :locations, :country
    add_index :locations, :region
    add_index :locations, :city
    add_index :locations, :zip
    add_index :locations, :latitue
    add_index :locations, :longitude
  end
end
