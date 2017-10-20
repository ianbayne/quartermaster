class ContractMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contract_mailer.new_contract.subject
  #
  def approval_of_rental(contract)
    @contract = contract
    @renter = contract.user
    @owner = contract.equipment.user

    mail(
      to: @renter.email,
      subject: "Thank you for using QuarterMaster"
    )
  end

  def notification_of_rental(contract)
    @contract = contract
    @owner = contract.equipment.user
    @renter = contract.user

    mail(
      to: @owner.email,
      subject: "Someone has reserved your equipment"
    )
  end
end
