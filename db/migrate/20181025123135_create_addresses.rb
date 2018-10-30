class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :city
      t.text :state
      t.string :pin_no

      t.timestamps
    end
  end
end
