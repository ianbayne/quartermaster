class Equipment < ApplicationRecord
  belongs_to :user
  has_many :contracts
  mount_uploader :photo, PhotoUploader
end
