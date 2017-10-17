class AddStartEndToContracts < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :start_time, :datetime
    add_column :contracts, :end_time, :datetime
  end
end
