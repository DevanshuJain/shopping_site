class RemoveMrpFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :mrp, :string
  end
end
