class AddPriceToEquipment < ActiveRecord::Migration[5.1]
  def change
    add_column :equipment, :price, :integer
  end
end
