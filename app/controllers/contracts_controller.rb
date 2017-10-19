class ContractsController < ApplicationController
  def new
    @equipment = Equipment.find(params[:equipment_id])
    @contract = Contract.new
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @contract = Contract.new(contract_params)

    @duration = @contract.end_time - @contract.start_time
    @duration_day = (@duration / 86400).to_i
    @contract.price = @equipment.price * @duration_day
    @contract.equipment = @equipment

    if @equipment.rented == false && @contract.save
      @equipment.update(rented: true)
      redirect_to user_path(params[:contract][:user_id])
    else
      flash[:alert] = "This equipment is already rented."
      @contract = Contract.new
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
