class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :surname
      t.string :passport
      t.boolean :hasLag
      t.boolean :hasPriv
      t.integer :category
      t.references :flight, foreign_key: true

      t.timestamps
    end
  end
end
