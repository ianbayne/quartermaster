class RemoveDurationFromContracts < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :duration, :datetime
  end
end
