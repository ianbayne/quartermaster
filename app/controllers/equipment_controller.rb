class EquipmentController < ApplicationController
  def show
    @equipment = Equipment.find(params[:id])
    @contract = Contract.new
    @equipment_coordinates = { 
      lat: @equipment.latitude, 
      lng: @equipment.longitude }
    @hash = Gmaps4rails.build_markers(@equipment) do |equipment, marker|
      marker.lat(@equipment_coordinates[:lat])
      marker.lng(@equipment_coordinates[:lng])
    end
  end

  def index
    @equipment = Equipment.all
  end

  def new
    @user = User.find(params[:user_id])
    @equipment = Equipment.new
  end

  def create
    @user = current_user
    @equipment = @user.equipment.build(equipment_params)
    @equipment.user = @user

    if @equipment.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])
  end

  def update
    @user = current_user
    @equipment = Equipment.find(params[:id])
    @equipment.update(equipment_params)
    redirect_to user_path(current_user)
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy
    redirect_to user_path(current_user)
  end

  private

  def equipment_params
    params.require(:equipment).permit(
      :name, :description, :category, :price, :address, :photo, :photo_cache)
  end

end
