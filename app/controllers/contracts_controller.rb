class ContractsController < ApplicationController
  def new
    @equipment = Equipment.find(params[:equipment_id])
    @contract = Contract.new
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @contract = Contract.new(contract_params)
    @contract.equipment = @equipment
    if @contract.save
      redirect_to user_path(params[:contract][:user_id])
    else
      render :new
    end
  end

  private

  def contract_params
    params.require(:contract).permit(
      "start_time(1i)", "start_time(2i)", "start_time(3i)", 
      "end_time(1i)", "end_time(2i)", "end_time(3i)", :user_id)
  end
end
