class ContractMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contract_mailer.new_contract.subject
  #
  def approval_of_rental(contract)
    @contract = contract
    @renter = contract.user_id

    mail(
      to: @renter.email,
      subject: "Welcome to QuarterMaster"
    )
  end

  def notification_of_rental(contract)
    @contract = contract
    @owner = contract.equipment.user_id

    mail(
      to: @owner.email,
      subject: "Welcome to QuarterMaster"
    )
  end
end
