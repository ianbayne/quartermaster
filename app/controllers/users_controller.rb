class UsersController < ApplicationController
  def show
    @user = current_user
    @contracts = @user.contracts.order(end_time: :asc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    # if equipment.location == @user_previous_location,
    # equipment is in user default location. so update with latest value.
    # otherwise, equipment location as is(equipment is in specific location) 
    if @user.update(user_params)
      @user_equipment = @user.equipment
      @user_equipment.each do |equipment|
        equipment.update( { address: @user.location } )
      end
      flash[:success] = "Your profile was updated correctly."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :location)
  end

end
