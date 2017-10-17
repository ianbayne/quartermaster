class EquipmentController < ApplicationController
  def show
    @equipment = Equipment.find(params[:id])
    @contract = Contract.new
  end

  def index
    @equipment = Equipment.all
  end

  def new
    @user = User.find(params[:user_id])
    @equipment = Equipment.new
  end

  def create
    @user = User.find(params[:user_id])
    @equipment = @user.equipment.build(equipment_params)
    @equipment.user = @user

    if @equipment.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])
  end

  def update
    @equipment = Equipment.find(params[:id])
    @equipment.update(equipment_params)
    @equipment.save
    redirect_to root_path
  end

  private

  def equipment_params
    params.require(:equipment).permit(
      :name, :description, :category, :photo, :photo_cache)
  end

end
