# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :continent, null: false
      t.string :country, null: false
      t.string :region, null: false
      t.string :city, null: false
      t.string :zip, null: false
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false
      t.belongs_to :internet_protocol, index: { unique: true }, foreign_key: { on_delete: :cascade }
    end
  end
end
