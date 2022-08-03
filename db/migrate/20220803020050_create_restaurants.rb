class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string       :shop_name,       null: false
      t.string       :address
      t.integer      :category_id,     null: false
      t.string       :phone_number
      t.string       :url
      t.references   :user,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
