class AddPrecisionToLocation < ActiveRecord::Migration[6.0]
  def change
    rename_column :locations, :latitue, :latitude
    change_column :locations, :latitude, :decimal
    change_column :locations, :longitude, :decimal
    change_column :locations, :latitude, :decimal, precision: 10
    change_column :locations, :longitude, :decimal, precision: 10
  end
end
