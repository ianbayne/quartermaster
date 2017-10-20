class ContractsController < ApplicationController
  def new
    @equipment = Equipment.find(params[:equipment_id])
    @contract = Contract.new
    # test
    @contracts_order_by_end_time = @equipment.contracts.order(end_time: :desc).limit(5)
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @contract = Contract.new(contract_params)
    # test
    @contracts_order_by_end_time = @equipment.contracts.order(end_time: :desc).limit(5)

    @duration = @contract.end_time - @contract.start_time
    @duration_day = (@duration / 86400).to_i
    @contract.price = @equipment.price * @duration_day
    @contract.equipment = @equipment

    contract_time_available = true

    # go thorough all contracts a equipment has.
    # need to reject below condition
    # new contract     ->           |-----|   |-----|
    # existing contract->             |-----------|
    # new contract     ->                |------|
    # new contract     ->         |---------------------|
    # below is ok(contracts does not contain each other)
    # new contract     ->     |-----|                |-----|
    # existing contract->             |-----------|
    @equipment.contracts.each do |existing_contract|
      existing_contract_start_time = existing_contract.start_time
      existing_contract_end_time = existing_contract.end_time
      # puts "@contract start_time", @contract.start_time
      # puts "@contract end_time", @contract.end_time
      # puts "existing_contract start_time", existing_contract.start_time
      # puts "existing_contract end_time", existing_contract.end_time

      start_time_between = @contract.start_time.between?(
        existing_contract_start_time, existing_contract_end_time)

      end_time_between = @contract.end_time.between?(
        existing_contract_start_time, existing_contract_end_time)

      existing_contract_start_time_between = existing_contract.start_time.between?(
        @contract.start_time, @contract.end_time)

      existing_contract_end_time_between = existing_contract.end_time.between?(
        @contract.start_time, @contract.end_time)

      # puts "start_time_between", start_time_between
      # puts "end_time_between", end_time_between
      # puts "existing_contract_start_time_between", existing_contract_start_time_between
      # puts "existing_contract_end_time_between", existing_contract_end_time_between
      contract_time_available = false if start_time_between || end_time_between || existing_contract_start_time_between || existing_contract_end_time_between
      puts "contract_time_available", contract_time_available
    end

    if contract_time_available == true && @contract.save
      @equipment.update(rented: true)
      redirect_to user_path(params[:contract][:user_id])
    else
      flash[:alert] = "This equipment is already rented in selected period."
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
