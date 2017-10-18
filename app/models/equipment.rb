class Equipment < ApplicationRecord
  belongs_to :user
  has_many :contracts
  mount_uploader :photo, PhotoUploader

  def self.search(search) #self. to set class method
    if search #parameter from Controller !=, search equipment name
      Equipment.where(['name ILIKE ?', "%#{search}%"])
    else
      Equipment.all #otherwise show all
    end
  end
end
