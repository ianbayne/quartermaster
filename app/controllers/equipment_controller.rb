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
    @user = User.find(params[:id])
    @equipment = Equipment.find(params[:id])
    @equipment.update(equipment_params)
    redirect_to user_path(@user)
  end

  private

  def equipment_params
    params.require(:equipment).permit(
      :name, :description, :category, :photo, :photo_cache)
  end

end
