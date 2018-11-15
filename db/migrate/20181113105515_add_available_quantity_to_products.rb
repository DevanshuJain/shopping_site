class AddAvailableQuantityToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :available_quantity, :integer, :default => '0'
  end
end
