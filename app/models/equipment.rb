class Equipment < ApplicationRecord
  belongs_to :user
  has_many :contracts, dependent: :destroy
  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.search(search) #self. to set class method
    if search # if parameter from Controller !=, search equipment name
      Equipment.where(['name ILIKE ?', "%#{search}%"])
    else
      Equipment.all #otherwise show all
    end
  end
end
