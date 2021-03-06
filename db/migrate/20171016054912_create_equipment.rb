class CreateEquipment < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :description
      t.string :category
      t.string :photo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
