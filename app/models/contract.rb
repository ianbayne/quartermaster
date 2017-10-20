class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :equipment
  # validates :price, numericality: { greater_than: 0 }
  # validates :user_id, presence: true
  # validates :equipment_id, presence: true

  after_create :send_contract_emails

  private

  def send_contract_emails
    ContractMailer.approval_of_rental(self).deliver_now
    ContractMailer.notification_of_rental(self).deliver_now
  end
end
