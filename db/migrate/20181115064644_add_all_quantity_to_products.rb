class AddAllQuantityToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :all_quantity, :integer
  end
end
