class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.datetime :duration
      t.integer :price
      t.references :user, foreign_key: true
      t.references :equipment, foreign_key: true

      t.timestamps
    end
  end
end
