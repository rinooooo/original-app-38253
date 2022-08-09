class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string       :nickname
      t.string       :comment
      t.references   :restaurant, null: false, foreign_key: true
      t.references   :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
