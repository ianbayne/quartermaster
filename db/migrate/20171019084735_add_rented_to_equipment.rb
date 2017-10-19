class AddRentedToEquipment < ActiveRecord::Migration[5.1]
  def change
    add_column :equipment, :rented, :boolean, default: false, null: false
  end
end
