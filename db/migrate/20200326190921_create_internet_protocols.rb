class CreateInternetProtocols < ActiveRecord::Migration[6.0]
  def change
    create_table :internet_protocols do |t|
      t.string :name, null: false
      t.index :name, unique: true
    end
  end
end
