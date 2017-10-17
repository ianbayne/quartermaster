class AddHostToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :host, :boolean, default: false, null: false
  end
end
