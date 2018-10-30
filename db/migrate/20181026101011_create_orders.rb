class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :total_product
      t.integer :total_price
      t.references :user, foreign_key: true
      t.boolean :status, :default => false

      t.timestamps
    end
  end
end
