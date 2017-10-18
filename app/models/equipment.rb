class Equipment < ApplicationRecord
  belongs_to :user
  has_many :contracts, dependent: :destroy
  mount_uploader :photo, PhotoUploader
end
