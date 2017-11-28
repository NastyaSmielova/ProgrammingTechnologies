class CreateFlights < ActiveRecord::Migration[5.1]
  def change
    create_table :flights do |t|
      t.string :destination
      t.time :time
      t.date :date
      t.integer :placesBus
      t.integer :placesStan
      t.integer :priceBus
      t.integer :priceStan
      t.integer :priceLag
      t.integer :pricePriv

      t.timestamps
    end
  end
end
