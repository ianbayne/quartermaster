class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :equipment
  # validates :price, numericality: { greater_than: 0 }
  # validates :user_id, presence: true
  # validates :equipment_id, presence: true
end
