class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :country
      t.string :city
      t.text :overview
      t.string :hotels
      t.string :thingsToDo
      t.string :resturants
      t.string :flights
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
