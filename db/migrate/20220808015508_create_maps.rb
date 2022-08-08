class CreateMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :maps do |t|
      t.string       :address
      t.float        :latitude
      t.float        :longitude
      t.references   :restaurant, null: false, foreign_key: true
      t.timestamps
    end
  end
end
