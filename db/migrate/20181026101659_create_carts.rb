class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :quantity
      t.integer :price
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
